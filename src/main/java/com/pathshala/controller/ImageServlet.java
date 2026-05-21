package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet("/getimage")
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR =
            System.getProperty("user.home") + File.separator + "pathshala_uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");

        if (name == null || name.trim().isEmpty() || name.contains("..")
                || name.contains("/") || name.contains("\\")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        File uploadDir = new File(UPLOAD_DIR);

        if (!uploadDir.exists() || !uploadDir.isDirectory()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String[] extensions = { ".jpg", ".jpeg", ".png", ".webp", ".gif" };
        File imageFile = null;

        for (String ext : extensions) {
            File file = new File(uploadDir, name + ext);

            if (file.exists() && file.isFile()) {
                imageFile = file;
                break;
            }
        }

        if (imageFile == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String contentType = getServletContext().getMimeType(imageFile.getName());

        if (contentType == null || !contentType.startsWith("image/")) {
            contentType = "image/jpeg";
        }

        response.setContentType(contentType);
        response.setContentLengthLong(imageFile.length());

        Files.copy(imageFile.toPath(), response.getOutputStream());
    }
}
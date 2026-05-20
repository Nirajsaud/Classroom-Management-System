package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/getimage")
public class GetImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");

        if (name == null || name.trim().isEmpty() || name.contains("..")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String folderPath = getServletContext().getRealPath("/profile-images");
        String[] extensions = { ".jpg", ".jpeg", ".png", ".webp" };

        File imageFile = null;

        for (String ext : extensions) {
            File file = new File(folderPath, name + ext);
            if (file.exists()) {
                imageFile = file;
                break;
            }
        }

        if (imageFile == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mimeType = getServletContext().getMimeType(imageFile.getName());
        if (mimeType == null) {
            mimeType = "image/jpeg";
        }

        response.setContentType(mimeType);

        try (FileInputStream input = new FileInputStream(imageFile);
             OutputStream output = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }
    }
}
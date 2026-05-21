package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/download")
public class DownloadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filePath = request.getParameter("file");

        if (filePath == null || filePath.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/classrooms");
            return;
        }

        filePath = filePath.replace("\\", "/");

        if (filePath.contains("..")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String realPath = getServletContext().getRealPath("/") + filePath;
        File file = new File(realPath);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found: " + realPath);
            return;
        }

        String fileName = file.getName();
        String mimeType = getServletContext().getMimeType(fileName);

        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }

        response.setContentType(mimeType);
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        response.setContentLengthLong(file.length());

        try (FileInputStream input = new FileInputStream(file);
             OutputStream output = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }
    }
}
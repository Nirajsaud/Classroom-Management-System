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
    
    // Defines a permanent, safe external folder on your computer
    private static final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "pathshala_uploads";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        
        if (name == null || name.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Image name required");
            return;
        }

        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Search for the user's file (e.g., looking for "admin@pathshala.com.jpg" or ".png")
        File[] matches = uploadDir.listFiles((dir, filename) -> filename.startsWith(name + "."));

        if (matches != null && matches.length > 0) {
            File imageFile = matches[0];
            
            // Dynamically set content type (image/jpeg, image/png, etc.)
            String contentType = getServletContext().getMimeType(imageFile.getName());
            if (contentType == null) {
                contentType = "application/octet-stream";
            }
            response.setContentType(contentType);
            response.setContentLengthLong(imageFile.length());

            // Copy file from hard drive to the browser's response stream
            Files.copy(imageFile.toPath(), response.getOutputStream());
        } else {
            // Send a 404 so the JSP's "onerror" script triggers the placeholder image
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
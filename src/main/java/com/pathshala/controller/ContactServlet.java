package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pathshala.model.ContactModel;
import com.pathshala.dao.ContactDAO;

@WebServlet(asyncSupported = true, urlPatterns = { "/contact" })
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Server-Side Validation Check
        if (name == null || name.trim().isEmpty() || 
            email == null || email.trim().isEmpty() || 
            subject == null || subject.trim().isEmpty() || 
            message == null || message.trim().isEmpty()) {
            
            request.setAttribute("error", "Please fill in all required fields.");
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
            return;
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
            return;
        }

        // Mapping raw inputs into object
        ContactModel contact = new ContactModel();
        contact.setName(name.trim());
        contact.setEmail(email.trim());
        contact.setPhone(phone != null ? phone.trim() : "");
        contact.setSubject(subject);
        contact.setMessage(message.trim());

        ContactDAO contactDAO = new ContactDAO();
        boolean isSaved = contactDAO.saveMessage(contact);

        if (isSaved) {
            request.setAttribute("success", "Thank you! Your message has been sent successfully.");
        } else {
            request.setAttribute("error", "A database system error occurred. Please try again later.");
        }

        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }
}
package com.pathshala.controller;

import com.pathshala.dao.StudentDAO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Servlet implementation class PaymentsServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/payment" })
public class PaymentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private StudentDAO studentDAO;

    public PaymentsServlet() {
        super();
    }

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null || !"student".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("totalPaid", studentDAO.getTotalPaid(user.getUserId()));
        request.setAttribute("activeClassCount", studentDAO.getActiveClassCount(user.getUserId()));
        request.setAttribute("paymentList", studentDAO.getPaymentHistory(user.getUserId()));

        request.getRequestDispatcher("WEB-INF/views/student/studentPayment.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
package com.pathshala.controller;

import com.pathshala.dao.StudentDAO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Servlet implementation class MakePaymentServlet
 */
@WebServlet("/makepayment")
public class MakePaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StudentDAO studentDAO;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MakePaymentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null || !"student".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int classId = Integer.parseInt(request.getParameter("classId"));
        double amountPaid = Double.parseDouble(request.getParameter("amountPaid"));
        String paymentMethod = request.getParameter("paymentMethod");

        int enrollmentId = studentDAO.createEnrollmentAndPayment(
                user.getUserId(),
                classId,
                amountPaid,
                paymentMethod
        );

        if (enrollmentId > 0) {
            response.sendRedirect(request.getContextPath() + "/subjects?payment=success");
        } else {
            response.sendRedirect(request.getContextPath() + "/classrooms?error=payment_failed");
        }
    }
}
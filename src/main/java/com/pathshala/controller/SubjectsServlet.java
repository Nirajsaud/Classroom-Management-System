package com.pathshala.controller;

import com.pathshala.dao.StudentDAO;
import com.pathshala.model.ClassroomModel;
import com.pathshala.model.SubjectModel;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = { "/subjects" })
public class SubjectsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private StudentDAO studentDAO;

    public SubjectsServlet() {
        super();
    }

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<ClassroomModel> enrolledClasses =
                studentDAO.getEnrolledClasses(user.getUserId());

        request.setAttribute("enrolledClasses", enrolledClasses);

        int classId = 0;

        String classParam = request.getParameter("classId");

        if (classParam != null && !classParam.trim().isEmpty()) {
            classId = Integer.parseInt(classParam);
        } else if (!enrolledClasses.isEmpty()) {
            classId = enrolledClasses.get(0).getClassId();
        }

        if (classId > 0) {

            request.setAttribute(
                "subjectList",
                studentDAO.getSubjectsByClass(classId)
            );

            request.setAttribute(
                "resourceList",
                studentDAO.getResourcesForStudent(classId)
            );
        }
        
        request.setAttribute("noticeList", studentDAO.getStudentNotices(user.getUserId()));

        request.getRequestDispatcher(
            "WEB-INF/views/student/studentSubject.jsp"
        ).forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}
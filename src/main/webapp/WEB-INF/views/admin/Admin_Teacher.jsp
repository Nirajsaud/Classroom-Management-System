<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Teachers – Pathshala</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin_Teacher.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="app-wrapper">
    <% request.setAttribute("activePage", "teachers"); %>
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/adminTopbar.jsp" />

        <main class="content-area">
            <div class="page-header">
                <div>
                    <h1 class="page-title-large">Manage Teacher</h1>
                    <p class="page-subtitle">View and manage faculty information across all Classrooms</p>
                </div>
                <a href="${pageContext.request.contextPath}/addteacher" class="add-teacher-btn">+ Add Teacher</a>
            </div>

            <div class="teachers-overview">
                <div class="teacher-stat-card">
                    <span class="teacher-stat-label">Total Faculty</span>
                    <span class="teacher-stat-value"><c:out value="${not empty totalTeachers ? totalTeachers : 0}"/></span>
                </div>
            </div>

            <section class="teacher-table-card">
                <div class="table-header-row">
                    <div>Name</div>
                    <div>Subject</div>
                    <div>Email</div>
                    <div>Phone No.</div>
                    <div>Action</div>
                </div>

                <c:choose>
                    <c:when test="${not empty teachers}">
                        <c:forEach var="teacher" items="${teachers}">
                            <div class="teacher-row">
                                <div class="teacher-name">
                                    <span class="avatar-gray">
                                        <c:out value="${fn:toUpperCase(fn:substring(teacher.fullName, 0, 1))}"/>
                                    </span>
                                    <span><c:out value="${teacher.fullName}"/></span>
                                </div>
                                <div><c:out value="${teacher.subject}"/></div>
                                <div><c:out value="${teacher.email}"/></div>
                                <div><c:out value="${not empty teacher.phone ? teacher.phone : 'N/A'}"/></div>
                                <div>
                                    <a href="${pageContext.request.contextPath}/teachers/edit?id=${teacher.teacherId}" class="edit-link">Edit</a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="teacher-row" style="grid-template-columns: 1fr; text-align: center; padding: 2rem; color: #6b7280;">
                            No teachers registered or allocated yet.
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="table-pagination" id="teacherPagination"></div>
            </section>
        </main>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/Admin_Teacher.js"></script>
</body>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classrooms – Pathshala</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Amin_Classroom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="app-wrapper">
    <% request.setAttribute("activePage", "classrooms"); %>
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/adminTopbar.jsp" />

        <main class="content-area">
            <div class="page-header">
                <div>
                    <h1 class="page-title-large">Classroom Directory</h1>
                    <p class="page-subtitle">View and manage all Classrooms</p>
                </div>
            </div>

            <section class="teacher-table-card">
                <div class="table-header-row">
                    <div>Classroom</div>
                    <div>Price</div>
                    <div>Total Students</div>
                    <div>Action</div>
                </div>

                <c:forEach var="classroom" items="${classrooms}">
                    <div class="teacher-row">
                        <div>${classroom.className}</div>
                        <div>Rs. ${classroom.price}</div>
                        <div>${classroom.totalStudents}</div>
                        <div>
                            <a class="manage-link" href="${pageContext.request.contextPath}/classrooms/manage?classId=${classroom.id}">Manage</a>
                        </div>
                    </div>
                </c:forEach>
            </section>
        </main>
    </div>
</div>
</body>
</html>
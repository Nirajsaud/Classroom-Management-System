<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Teacher Dashboard</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacherDashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notification.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacher-common.css">
</head>
<body>

<c:set var="activePage" value="dashboard" scope="request" />
<jsp:include page="/WEB-INF/views/teacher/teacherNavbar.jsp" />

<main class="dashboard-container">

    <section class="welcome-section">
        <h1>
            Welcome Back,
            <span class="teacher-name">
                <c:choose>
                    <c:when test="${not empty user.fullName}">
                        ${user.fullName}
                    </c:when>
                    <c:otherwise>
                        Teacher
                    </c:otherwise>
                </c:choose>
            </span>
        </h1>
        <p>What would you like to do today?</p>
    </section>

    <section class="cards-grid">
        <a href="${pageContext.request.contextPath}/classrooms" class="feature-card card-blue">
            <h2>Classroom</h2>
            <div class="card-divider"></div>

            <div class="card-body">
                <h3>
                    <c:choose>
                        <c:when test="${not empty assignedClassCount}">
                            ${assignedClassCount} Assigned Classroom
                        </c:when>
                        <c:otherwise>
                            Assigned Classroom
                        </c:otherwise>
                    </c:choose>
                </h3>
                <p>Check your assigned classrooms and manage the study resources for your students.</p>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/students" class="feature-card card-orange">
            <h2>Students</h2>
            <div class="card-divider"></div>

            <div class="card-body">
                <h3>
                    <c:choose>
                        <c:when test="${not empty studentCount}">
                            ${studentCount} Students
                        </c:when>
                        <c:otherwise>
                            Student Activity
                        </c:otherwise>
                    </c:choose>
                </h3>
                <p>View students enrolled in your assigned classrooms.</p>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/classrooms" class="feature-card card-navy">
            <h2>Study Resources</h2>
            <div class="card-divider"></div>

            <div class="card-body">
                <h3>
                    <c:choose>
                        <c:when test="${not empty materialCount}">
                            ${materialCount} Uploaded Materials
                        </c:when>
                        <c:otherwise>
                            Upload Materials
                        </c:otherwise>
                    </c:choose>
                </h3>
                <p>Upload and manage study resources for the classrooms assigned to you.</p>
            </div>
        </a>
    </section>

    <section class="notice-board">
        <h2>Notice Board</h2>

        <div class="board-content">
            <c:choose>
                <c:when test="${empty noticeList}">
                    <div class="notice-item">
                        <span class="timestamp">No notices yet</span>
                        <p>Recent classroom notices and material updates will appear here.</p>
                    </div>
                </c:when>

                <c:otherwise>
                    <c:forEach var="notice" items="${noticeList}">
                        <div class="notice-item">
                            <span class="timestamp">${notice.createdAt}</span>
                            <h3>${notice.title}</h3>
                            <p>${notice.content}</p>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

</main>

<script src="${pageContext.request.contextPath}/js/notification.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Student Dashboard</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentDashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notification.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-common.css">
</head>
<body>

<c:set var="activePage" value="dashboard" scope="request" />
<jsp:include page="/WEB-INF/views/student/studentNavbar.jsp" />

<main class="dashboard-container">

    <header class="welcome-section">
        <h1>Welcome Back, <span class="underlined-name">${user.fullName}</span></h1>
        <p>What would you like to do today?</p>
    </header>

    <section class="action-grid">
        <a href="${pageContext.request.contextPath}/subjects" class="card card-subjects">
            <div class="card-header">
                <h2>Subjects</h2>
            </div>
            <div class="card-body">
                <p>View and access materials from the classrooms you have enrolled in.</p>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/classrooms" class="card card-classrooms">
            <div class="card-header">
                <h2>Classrooms</h2>
            </div>
            <div class="card-body">
                <p>Browse available classroom packages from Grade 4 to 10 and purchase the ones you want to join.</p>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/payment" class="card card-payments">
            <div class="card-header">
                <h2>My Payments</h2>
            </div>
            <div class="card-body">
                <p>Check your payments, expiry dates, and renew classroom subscriptions.</p>
            </div>
        </a>
    </section>

    <section class="notification-panel">
        <div class="notif-title">
            <h2>Notification</h2>
        </div>

        <div class="notif-content">
            <c:choose>
                <c:when test="${empty noticeList}">
                    <div class="notif-row">
                        <span class="timestamp">No notices yet</span>
                        <p class="message">New classroom updates and study materials will appear here.</p>
                    </div>
                </c:when>

                <c:otherwise>
                    <c:forEach var="notice" items="${noticeList}">
                        <div class="notif-row">
                            <span class="timestamp">${notice.createdAt}</span>
                            <p class="message">
                                <strong>${notice.title}</strong><br>
                                ${notice.content}
                            </p>
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
<!-- src/main/webapp/WEB-INF/views/student/classroom.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Student Classrooms</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentClassroom.css">
</head>
<body>

<header class="main-nav">
    <div class="nav-container">
        <div class="logo-area">
            <span class="pathshala-logo">pathshala</span>
        </div>

        <nav class="center-links">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                <i class="fa-solid fa-table-cells-large"></i> Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/student/classroom" class="nav-link active">
                <i class="fa-solid fa-pen-nib"></i> Classrooms
            </a>

            <a href="${pageContext.request.contextPath}/student/subjects" class="nav-link">
                <i class="fa-solid fa-book"></i> Subjects
            </a>

            <a href="${pageContext.request.contextPath}/student/payment" class="nav-link">
                <i class="fa-solid fa-wallet"></i> Payment
            </a>
        </nav>

        <div class="user-controls">
            <i class="fa-regular fa-bell bell-icon"></i>

            <div class="v-divider"></div>

            <a href="${pageContext.request.contextPath}/student/profile" class="profile-icon">
                <i class="fa-solid fa-user"></i>
            </a>

            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </div>
</header>

<main class="classroom-page">

    <section class="page-heading">
        <h1>Available Classrooms</h1>
        <p>Browse class packages, search by grade, and purchase access to start learning.</p>
    </section>

    <form method="get" action="${pageContext.request.contextPath}/student/classroom" class="filter-bar">
        <div class="search-box">
            <i class="fa-solid fa-magnifying-glass search-icon"></i>

            <input type="text"
                   name="keyword"
                   value="${keyword}"
                   placeholder="Search classroom, example Grade 5">
        </div>

        <button type="submit" class="search-btn">Search</button>

        <select name="sort" class="filter-select" onchange="this.form.submit()">
            <option value="default" ${sort == 'default' ? 'selected' : ''}>Default</option>
            <option value="low" ${sort == 'low' ? 'selected' : ''}>Lowest Price First</option>
            <option value="high" ${sort == 'high' ? 'selected' : ''}>Highest Price First</option>
        </select>
    </form>

    <section class="classroom-grid">

        <c:choose>
            <c:when test="${empty classroomList}">
                <div class="empty-card">
                    <i class="fa-regular fa-folder-open"></i>
                    <h2>No classroom found</h2>
                    <p>Try searching with another grade or reset the filter.</p>
                </div>
            </c:when>

            <c:otherwise>
                <c:forEach var="classroom" items="${classroomList}">
                    <article class="classroom-card">
                        <div class="book-icon">
                            <i class="fa-solid fa-book-open"></i>
                        </div>

                        <div class="card-divider"></div>

                        <div class="classroom-info">
                            <h2>${classroom.className}</h2>
                            <p>Full ${classroom.className} syllabus with study materials.</p>
                            <h3>Rs. ${classroom.price}</h3>

                            <c:choose>
                                <c:when test="${classroom.enrolled}">
                                    <button type="button" class="buy-btn enrolled-btn" disabled>
                                        <i class="fa-solid fa-check"></i>
                                        Already Enrolled
                                    </button>
                                </c:when>

                                <c:otherwise>
                                    <form method="get" action="${pageContext.request.contextPath}/student/payment">
                                        <input type="hidden" name="classId" value="${classroom.classId}">

                                        <button type="submit" class="buy-btn">
                                            <i class="fa-regular fa-square-plus"></i>
                                            Buy Package
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </article>
                </c:forEach>
            </c:otherwise>
        </c:choose>

    </section>

</main>

</body>
</html>
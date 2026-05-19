<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page isELIgnored="false" %>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Pathshala | Student Subjects</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/studentSubject.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/notification.css">
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


            <a href="${pageContext.request.contextPath}/classrooms"
               class="nav-link">

                <i class="fa-solid fa-pen-nib"></i>
                Classrooms

            </a>


            <a href="${pageContext.request.contextPath}/subjects"
               class="nav-link active">

                <i class="fa-solid fa-book"></i>
                Subjects

            </a>

            <a href="${pageContext.request.contextPath}/payments"
               class="nav-link">

                <i class="fa-solid fa-wallet"></i>
                Payment

            </a>
        </nav>
<div class="user-controls">

    <div class="bell-wrapper" id="bellWrapper">
        <button type="button" class="bell-btn" id="bellBtn">
            <i class="fa-regular fa-bell"></i>
        </button>

        <c:if test="${not empty noticeList}">
            <span class="bell-badge" id="bellBadge"></span>
        </c:if>

        <div class="notif-dropdown" id="notifDropdown">
            <div class="notif-header">
                <h4>Notifications</h4>
                <button type="button" class="notif-mark-all" id="markAllRead">
                    Dismiss all
                </button>
            </div>


            <div class="notif-list" id="notifList">
                <c:choose>
                    <c:when test="${empty noticeList}">
                        <div class="notif-footer">
                            <p>No notifications yet.</p>
                        </div>
                    </c:when>


                    <c:otherwise>
                        <c:forEach var="notice" items="${noticeList}">
                            <div class="notif-item unread">
                                <div class="notif-dot"></div>

<<<<<<< HEAD
                                <div class="notif-content">
                                    <div class="notif-title">${notice.title}</div>
                                    <div class="notif-text">${notice.content}</div>
                                    <div class="notif-time">${notice.createdAt}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="v-divider"></div>

<a href="${pageContext.request.contextPath}/student/profile"
   class="profile-icon">

    <img src="${pageContext.request.contextPath}/getimage?name=${user.email}"
         alt="Profile"
         class="nav-profile-image"

         onerror="this.style.display='none';
                  this.nextElementSibling.style.display='flex';">

    <div class="default-profile-icon">
        <i class="fa-solid fa-user"></i>
    </div>

</a>

    <a href="${pageContext.request.contextPath}/logout-user" class="logout-btn">Logout</a>

</div>
</div>
</header>


<main class="subject-page">

    <section class="page-header">

        <h1>Study Resources</h1>

        <p>
            Access your classroom study materials and download resources.
        </p>

    </section>

    <section class="top-controls">

        <form method="get"
              action="${pageContext.request.contextPath}/student/subjects"
              class="filter-form">

            <select class="filter-select"
                    name="classId">

                <c:forEach var="classroom"
                           items="${enrolledClasses}">

                    <option value="${classroom.classId}">
                        ${classroom.className}
                    </option>

                </c:forEach>

            </select>

            <select class="filter-select"
                    name="subjectName">

                <c:forEach var="subject"
                           items="${subjectList}">

                    <option value="${subject.subjectName}">
                        ${subject.subjectName}
                    </option>

                </c:forEach>

            </select>

            <button type="submit"
                    class="filter-btn">

                Load Resources
            </button>

        </form>

    </section>

    <section class="resource-section">

        <c:choose>

            <c:when test="${empty resourceList}">

                <div class="empty-resource">

                    <i class="fa-regular fa-folder-open"></i>

                    <h3>No study resources found</h3>

                    <p>
                        Select a class and subject to load resources.
                    </p>

                </div>

            </c:when>

            <c:otherwise>

                <c:forEach var="resource"
                           items="${resourceList}">

                    <div class="resource-card">

                        <div class="resource-left">

                            <div class="resource-icon">

                                <i class="fa-solid fa-file-lines"></i>

                            </div>

                            <div class="resource-info">

                                <h3>${resource.title}</h3>

                                <p>
    								${resource.filePath}
								</p>

                            </div>

                        </div>

                        <div class="resource-right">

                            <span class="upload-date">
                                Uploaded:
                                ${resource.uploadedAt}
                            </span>

                            <a href="${pageContext.request.contextPath}/download?file=${resource.filePath}"
                               class="download-btn">

                                Download
                            </a>

                        </div>

                    </div>

                </c:forEach>

            </c:otherwise>

        </c:choose>

    </section>

</main>
<script src="${pageContext.request.contextPath}/js/notification.js"></script>
</body>
</html>
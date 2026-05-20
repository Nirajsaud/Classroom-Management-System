<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Teacher Classroom</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacherClassroom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notification.css">
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


            <a href="${pageContext.request.contextPath}/classrooms" class="nav-link active">

                <i class="fa-solid fa-pen-nib"></i> Classrooms
            </a>


            <a href="${pageContext.request.contextPath}/students" class="nav-link">
                <i class="fa-solid fa-book-open"></i> Students

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
                        <button type="button" class="notif-mark-all" id="markAllRead">Dismiss all</button>
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

           <a href="${pageContext.request.contextPath}/profile"
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

<main class="classroom-page">

    <section class="page-header">
        <h1>Study Resources</h1>
        <p>Upload and manage study materials for your assigned classrooms.</p>
    </section>

    <section class="top-controls">

        <form method="get" action="${pageContext.request.contextPath}/classrooms" class="filters">

            <select class="filter-select" name="classId" onchange="this.form.submit()">
                <option value="0">All Classes</option>

                <c:forEach var="classroom" items="${teacherClasses}">
                    <option value="${classroom.classId}" ${selectedClassId == classroom.classId ? 'selected' : ''}>
                        ${classroom.className}
                    </option>
                </c:forEach>
            </select>
        </form>

        <button type="button" class="upload-btn" id="openUploadBtn">
            Upload Material
        </button>
    </section>

    <section class="classroom-panel">
        <div class="resource-box">
            <div class="box-top">
                <h2>Study Resources</h2>
                <div class="student-count">${fn:length(studyResources)} Files</div>
            </div>

            <div class="box-divider"></div>

            <c:choose>
                <c:when test="${empty studyResources}">
                    <div class="empty-resource">
                        <i class="fa-regular fa-folder-open"></i>
                        <h3>No study resources found</h3>
                        <p>Upload materials for your selected classroom.</p>
                    </div>
                </c:when>

                <c:otherwise>
                    <c:forEach var="material" items="${studyResources}">
                        <div class="resource-item">
                            <div class="resource-text">
                                <h3>${material.title}</h3>
                                <p>${material.filePath}</p>
                            </div>

                            <div class="resource-actions">

    <a href="${pageContext.request.contextPath}/${material.filePath}"
       target="_blank"
       class="preview-btn">
        Preview
    </a>

    <a href="${pageContext.request.contextPath}/download?file=${fn:escapeXml(material.filePath)}"
       class="download-btn">
        Download
    </a>

    <form method="post"
          action="${pageContext.request.contextPath}/delete-material">

        <input type="hidden"
               name="materialId"
               value="${material.materialId}">

        <button type="submit"
                class="delete-btn">
            Delete
        </button>

    </form>

</div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

</main>

<div class="upload-overlay" id="uploadOverlay">
    <div class="upload-modal">
        <form action="${pageContext.request.contextPath}/upload-material" method="post" enctype="multipart/form-data">

            <label for="materialFile" class="upload-drop-area">
                <i class="fa-solid fa-arrow-up-from-bracket" id="uploadIcon"></i>

                <span id="uploadText">
                    Drag & Drop or <strong>Choose file</strong> to upload
                </span>

                <input type="file" id="materialFile" name="materialFile" hidden required>
            </label>

            <textarea name="title" placeholder="Add title or description about the study resource." required></textarea>

            <div class="upload-select-row">
                <div class="upload-select-group">
                    <label>Choose Classroom</label>

                    <select name="classId" required>
                        <option value="">Classroom</option>

                        <c:forEach var="classroom" items="${teacherClasses}">
                            <option value="${classroom.classId}">
                                ${classroom.className}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="upload-actions">
                <button type="button" class="cancel-upload-btn" id="cancelUploadBtn">Cancel</button>
                <button type="submit" class="submit-upload-btn">Upload</button>
            </div>

        </form>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/teacherClassroom.js"></script>
<script src="${pageContext.request.contextPath}/js/notification.js"></script>
</body>
</html>
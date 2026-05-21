<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacher-common.css">
</head>
<body>

<c:set var="activePage" value="classrooms" scope="request" />
<jsp:include page="/WEB-INF/views/teacher/teacherNavbar.jsp" />

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

                                <form method="post" action="${pageContext.request.contextPath}/delete-material">
                                    <input type="hidden" name="materialId" value="${material.materialId}">
                                    <button type="submit" class="delete-btn">Delete</button>
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

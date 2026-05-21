<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Teacher Students</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacherSubject.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notification.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacher-common.css">
</head>
<body>

<c:set var="activePage" value="students" scope="request" />
<jsp:include page="/WEB-INF/views/teacher/teacherNavbar.jsp" />

<main class="students-page">
    <section class="page-header">
        <h1>Students Directory</h1>
        <p>View students enrolled in the classes assigned to you.</p>
    </section>

    <section class="summary-card">
        <h3>Total Assigned Students</h3>
        <p>${totalStudents}</p>
    </section>

    <section class="filter-section">
        <form method="get" action="${pageContext.request.contextPath}/students" class="filter-form">
            <select name="classId" class="filter-select" onchange="this.form.submit()">
                <option value="0">All Classes</option>

                <c:forEach var="classroom" items="${teacherClasses}">
                    <option value="${classroom.classId}" ${selectedClassId == classroom.classId ? 'selected' : ''}>
                        ${classroom.className}
                    </option>
                </c:forEach>
            </select>
        </form>

        <span class="total-label">Total: ${fn:length(studentList)}</span>
    </section>

    <section class="table-card">
        <c:choose>
            <c:when test="${empty studentList}">
                <div class="empty-students">
                    <i class="fa-regular fa-folder-open"></i>
                    <h3>No students found</h3>
                    <p>No students are enrolled in this class configuration context yet.</p>
                </div>
            </c:when>

            <c:otherwise>
                <div class="table-wrapper">
                    <table class="students-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone No</th>
                                <th>Class</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="student" items="${studentList}">
                                <tr>
                                    <td><c:out value="${student.fullName}"/></td>
                                    <td><c:out value="${student.email}"/></td>
                                    <td><c:out value="${student.phoneNumber}"/></td>
                                    <td><c:out value="${student.className}"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/notification.js"></script>
</body>
</html>

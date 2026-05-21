<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students – Pathshala</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin_Students.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="app-wrapper">
    <% request.setAttribute("activePage", "students"); %>
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/adminTopbar.jsp" />

        <main class="content-area">
            <div class="page-header">
                <div>
                    <h1 class="page-title-large">Students Directory</h1>
                    <p class="page-subtitle">View and manage student accounts across all Classrooms</p>
                </div>
            </div>

            <div class="teachers-overview">
                <div class="teacher-stat-card">
                    <span class="teacher-stat-label">Total Registered Students</span>
                    <span class="teacher-stat-value">${totalStudents}</span>
                </div>
            </div>

            <section class="teacher-table-card">
                <div class="filter-row">
                    <div class="filter-select">
                        <form method="get" action="${pageContext.request.contextPath}/students">
                            <select name="classId" onchange="this.form.submit()" style="padding: 0.6rem 1rem; border-radius: 8px; border: 1px solid #e2e8f0; font-family: inherit; font-size: 0.95rem; background-color: #fff; cursor: pointer;">
                                <option value="0">All Students</option>
                                <c:forEach var="classroom" items="${classList}">
                                    <option value="${classroom.classId}" ${selectedClassId == classroom.classId ? 'selected' : ''}>
                                        ${classroom.className}
                                    </option>
                                </c:forEach>
                            </select>
                        </form>
                    </div>
                    <div class="table-total">Total : ${fn:length(studentList)}</div>
                </div>

                <div class="table-header-row">
                    <div>Name</div>
                    <div>Email</div>
                    <div>Phone No.</div>
                    <div>Enrolled Class</div>
                    
                </div>

                <c:choose>
                    <c:when test="${empty studentList}">
                        <div style="text-align: center; padding: 4rem 2rem; color: #64748b;">
                            <p style="font-size: 1.2rem; font-weight: 600; margin-bottom: 0.25rem;">No students found</p>
                            <p style="font-size: 0.9rem;">There are no active records matching this class filter lookup parameter.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="student" items="${studentList}">
                            <div class="teacher-row">
                                <div class="teacher-name">
                                    <span class="avatar-gray">${fn:toUpperCase(fn:substring(student.fullName, 0, 1))}</span>
                                    <span><c:out value="${student.fullName}"/></span>
                                </div>
                                <div><c:out value="${student.email}"/></div>
                                <div><c:out value="${student.phoneNumber}"/></div>
                                <div style="color: #64748b; font-size: 0.9rem;"><c:out value="${student.className}"/></div>
                                
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                <div class="table-pagination" id="studentPagination"></div>
            </section>
        </main>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/Admin_Students.js"></script>
</body>
</html>
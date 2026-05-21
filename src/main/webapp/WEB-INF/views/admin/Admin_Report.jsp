<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report – Pathshala</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin_Report.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="app-wrapper">
    <% request.setAttribute("activePage", "report"); %>
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/adminTopbar.jsp" />

        <main class="content-area">
            <div class="page-header">
                <div>
                    <h1 class="page-title-large">Report Overview</h1>
                </div>
                
                <a href="${pageContext.request.contextPath}/report?action=download" class="download-btn" id="downloadReportBtn" style="text-decoration: none; display: inline-flex; align-items: center; gap: 8px;">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="18" height="18">
                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                        <polyline points="7 10 12 15 17 10"/>
                        <line x1="12" y1="15" x2="12" y2="3"/>
                    </svg>
                    Download Report
                </a>
            </div>

            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-label">Total Students</div>
                    <div class="stat-value">${totalStudents}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Total Teachers</div>
                    <div class="stat-value">${totalTeachers}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Total Revenue</div>
                    <div class="stat-value">Rs. ${totalRevenue}</div>
                </div>
            </div>

            <div class="report-main-container">
                <div class="report-table-section">
                    <h3>Payment Collected Per Classroom</h3>
                    <table class="report-table">
                        <thead>
                            <tr>
                                <th>Classroom</th>
                                <th>No.of Active Students</th>
                                <th>Total Revenue</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${classroomReports}">
                                <tr>
                                    <td>${row.className}</td>
                                    <td>${row.totalStudents}</td>
                                    <td>Rs. ${row.totalRevenue}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="report-sidebar">
                    <div class="report-card">
                        <div class="card-label">Active Enrollments</div>
                        <div class="card-value">${activeEnrollments}</div>
                    </div>
                    <div class="report-card">
                        <div class="card-label">Pending Enrollments</div>
                        <div class="card-value">${pendingEnrollments}</div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/Admin_Report.js"></script>
</body>
</html>
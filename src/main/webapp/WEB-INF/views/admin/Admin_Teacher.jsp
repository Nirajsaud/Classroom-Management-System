<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Teachers – Pathshala</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin_Teacher.css">
</head>
<body>
<div class="app-wrapper">

    <aside class="sidebar">
        <div class="sidebar-logo">pathshala</div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="3" width="7" height="7" rx="1"/>
                    <rect x="14" y="3" width="7" height="7" rx="1"/>
                    <rect x="3" y="14" width="7" height="7" rx="1"/>
                    <rect x="14" y="14" width="7" height="7" rx="1"/>
                </svg>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/teachers" class="nav-item active">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M22 10v6M2 10l10-5 10 5-10 5z"/>
                    <path d="M6 12v5c3 3 9 3 12 0v-5"/>
                </svg>
                <span>Teachers</span>
            </a>
            <a href="${pageContext.request.contextPath}/students" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                    <circle cx="9" cy="7" r="4"/>
                    <path d="M23 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/>
                </svg>
                <span>Students</span>
            </a>
            <a href="${pageContext.request.contextPath}/classrooms" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                    <polyline points="9 22 9 12 15 12 15 22"/>
                </svg>
                <span>Classrooms</span>
            </a>
            <a href="${pageContext.request.contextPath}/report" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                    <polyline points="14 2 14 8 20 8"/>
                    <line x1="16" y1="13" x2="8" y2="13"/>
                    <line x1="16" y1="17" x2="8" y2="17"/>
                    <polyline points="10 9 9 9 8 9"/>
                </svg>
                <span>Report</span>
            </a>
            <a href="${pageContext.request.contextPath}/admincontact" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M21 8v10a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8"/>
                    <path d="M3 8l9 6 9-6"/>
                    <path d="M12 14v7"/>
                </svg>
                <span>Contact</span>
            </a>
        </nav>
    </aside>

    <div class="main-area">
        <header class="topbar">
            <div class="bell-wrapper">
                <a href="${pageContext.request.contextPath}/approvals"
                    class="bell-btn" title="Pending Approvals"
                    style="display: flex; align-items: center; text-decoration: none; position: relative;">
                    <svg class="bell-icon" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2"
                        style="width: 24px; height: 24px; color: #111827;">
                        <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9" />
                        <path d="M13.73 21a2 2 0 0 1-3.46 0" /></svg> 
                    <c:if test="${pendingCount > 0}">
                        <span class="bell-badge"
                            style="position: absolute; top: -2px; right: -2px; width: 10px; height: 10px; background: #ef4444; border-radius: 50%;"></span>
                    </c:if>
                </a>
            </div>
            <div class="topbar-divider"></div>
            
            <a href="${pageContext.request.contextPath}/profile" class="user-avatar" title="Profile" style="display: inline-block; width: 40px; height: 40px; overflow: hidden; border-radius: 50%;">
                <img src="${pageContext.request.contextPath}/getimage?name=${user.email}" 
                     alt="Profile"
                     onerror="this.src='https://via.placeholder.com/80';"
                     style="width: 100%; height: 100%; object-fit: cover; display: block; border-radius: 50%;">
            </a>

            <a href="${pageContext.request.contextPath}/logout-user" class="logout-btn" style="text-decoration: none; display: inline-flex; align-items: center; justify-content: center;">Logout</a>
        </header>

        <main class="content-area">
            <div class="page-header">
                <div>
                    <h1 class="page-title-large">Manage Teacher</h1>
                    <p class="page-subtitle">View and manage faculty information across all Classrooms</p>
                </div>
                <a href="${pageContext.request.contextPath}/addteacher" class="add-teacher-btn">+ Add Teacher</a>
            </div>

            <div class="teachers-overview">
                <div class="teacher-stat-card">
                    <span class="teacher-stat-label">Total Faculty</span>
                    <span class="teacher-stat-value"><c:out value="${not empty totalTeachers ? totalTeachers : 0}"/></span>
                </div>
            </div>

            <section class="teacher-table-card">
                <div class="table-header-row">
                    <div>Name</div>
                    <div>Subject</div>
                    <div>Email</div>
                    <div>Phone No.</div>
                    <div>Action</div>
                </div>

                <c:choose>
                    <c:when test="${not empty teachers}">
                        <c:forEach var="teacher" items="${teachers}">
                            <div class="teacher-row">
                                <div class="teacher-name">
                                    <span class="avatar-gray">
                                        <c:out value="${fn:toUpperCase(fn:substring(teacher.fullName, 0, 1))}"/>
                                    </span>
                                    <span><c:out value="${teacher.fullName}"/></span>
                                </div>
                                <div><c:out value="${teacher.subject}"/></div>
                                <div><c:out value="${teacher.email}"/></div>
                                <div><c:out value="${not empty teacher.phone ? teacher.phone : 'N/A'}"/></div>
                                <div>
                                    <a href="${pageContext.request.contextPath}/teachers/edit?id=${teacher.teacherId}" class="edit-link">Edit</a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="teacher-row" style="grid-template-columns: 1fr; text-align: center; padding: 2rem; color: #6b7280;">
                            No teachers registered or allocated yet.
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="table-pagination" id="teacherPagination"></div>
            </section>
        </main>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/Admin_Teacher.js"></script>
</body>
</html>
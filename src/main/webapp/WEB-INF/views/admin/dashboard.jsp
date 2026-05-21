<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Admin Dashboard – Pathshala</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminDashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
</head>
<body>

<div class="app-wrapper">
    <% request.setAttribute("activePage", "dashboard"); %>
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/adminTopbar.jsp" />

        <main class="content-area">

            <div class="stat-row">

                <div class="stat-card blue">
                    <div class="stat-text">
                        <span class="stat-label">Total Students</span>
                        <span class="stat-value" data-target="${totalStudents}" data-prefix="">
                            <span class="count-target">${totalStudents}</span>
                        </span>
                    </div>
                    <div class="stat-icon-wrap">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                            <circle cx="12" cy="7" r="4"/>
                        </svg>
                    </div>
                </div>

                <div class="stat-card orange">
                    <div class="stat-text">
                        <span class="stat-label">Total Teachers</span>
                        <span class="stat-value" data-target="${totalTeachers}" data-prefix="">
                            <span class="count-target">${totalTeachers}</span>
                        </span>
                    </div>
                    <div class="stat-icon-wrap">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                            <circle cx="9" cy="7" r="4"/>
                            <path d="M23 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/>
                        </svg>
                    </div>
                </div>

                <div class="stat-card green">
                    <div class="stat-text">
                        <span class="stat-label">Payment Collected</span>
                        <span class="stat-value" data-target="${totalRevenue}" data-prefix="Rs ">
                            <span class="count-target">Rs ${totalRevenue}</span>
                        </span>
                    </div>
                    <div class="stat-icon-wrap">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="1" y="4" width="22" height="16" rx="2" ry="2"/>
                            <line x1="1" y1="10" x2="23" y2="10"/>
                        </svg>
                    </div>
                </div>

            </div>

            <div class="action-grid">

                <a href="${pageContext.request.contextPath}/teachers" class="action-card teal">
                    <div class="action-title">Manage Teachers</div>
                    <hr class="action-divider">
                    <p class="action-body">Add, remove and manage teacher accounts and assign them to subjects across classrooms.</p>
                    <span class="action-arrow">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="5" y1="12" x2="19" y2="12"/>
                            <polyline points="12 5 19 12 12 19"/>
                        </svg>
                    </span>
                </a>

                <a href="${pageContext.request.contextPath}/students" class="action-card purple">
                    <div class="action-title">Students Directory</div>
                    <hr class="action-divider">
                    <p class="action-body">View all registered students, filter by classroom and access individual student profiles.</p>
                    <span class="action-arrow">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="5" y1="12" x2="19" y2="12"/>
                            <polyline points="12 5 19 12 12 19"/>
                        </svg>
                    </span>
                </a>

                <a href="${pageContext.request.contextPath}/classrooms" class="action-card amber">
                    <div class="action-title">Classroom Directory</div>
                    <hr class="action-divider">
                    <p class="action-body">View all classrooms, monitor enrolled student counts, and manage pricing for each grade.</p>
                    <span class="action-arrow">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="5" y1="12" x2="19" y2="12"/>
                            <polyline points="12 5 19 12 12 19"/>
                        </svg>
                    </span>
                </a>

                <a href="${pageContext.request.contextPath}/report" class="action-card emerald">
                    <div class="action-title">Report Overview</div>
                    <hr class="action-divider">
                    <p class="action-body">Track total students, teachers, revenue, payments per classroom and monitor active and pending enrollments.</p>
                    <span class="action-arrow">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="5" y1="12" x2="19" y2="12"/>
                            <polyline points="12 5 19 12 12 19"/>
                        </svg>
                    </span>
                </a>

            </div>

        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/adminDashboard.js"></script>
</body>
</html>
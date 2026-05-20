<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${className} – Pathshala</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Amin_Classroom.css">
</head>
<body>
<div class="app-wrapper">
    <aside class="sidebar">
        <div class="sidebar-logo">pathshala</div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/></svg>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/teachers" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c3 3 9 3 12 0v-5"/></svg>
                <span>Teachers</span>
            </a>
            <a href="${pageContext.request.contextPath}/students" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                <span>Students</span>
            </a>
            <a href="${pageContext.request.contextPath}/classrooms" class="nav-item active">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
                <span>Classrooms</span>
            </a>
            <a href="${pageContext.request.contextPath}/report" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg>
                <span>Report</span>
            </a>
            <a href="${pageContext.request.contextPath}/admincontact" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 8v10a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8"/><path d="M3 8l9 6 9-6"/><path d="M12 14v7"/></svg>
                <span>Contact</span>
            </a>
        </nav>
    </aside>

    <div class="main-area">
        <header class="topbar">
            <div class="bell-wrapper">
                <a href="${pageContext.request.contextPath}/approvals" class="bell-btn" title="Pending Approvals" style="display: flex; align-items: center; text-decoration: none; position: relative;">
                    <svg class="bell-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width: 24px; height: 24px; color: #111827;">
                        <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9" /><path d="M13.73 21a2 2 0 0 1-3.46 0" />
                    </svg> 
                    <c:if test="${pendingCount > 0}">
                        <span class="bell-badge" style="position: absolute; top: -2px; right: -2px; width: 10px; height: 10px; background: #ef4444; border-radius: 50%;"></span>
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
            <div class="form-header">
                <a href="${pageContext.request.contextPath}/classrooms" class="btn-cancel">Back</a>
                <h1 class="form-title">Classroom Details</h1>
            </div>

            <div class="classroom-details-card">
                <h1 class="classroom-name-heading">${className}</h1>

                <div class="classroom-details-body">
                    <div class="classroom-left-col">
                        <div class="classroom-info-block">
                            <label class="info-label">Total Students Enrolled</label>
                            <div class="info-value-box">${totalStudents}</div>
                        </div>

                        <div class="classroom-info-block" style="background:#f8fafc; padding:15px; border-radius:8px; border:1px solid #e2e8f0; margin-top:20px;">
                            <label class="info-label" style="margin-bottom:10px; display:block;">Update Classroom Price (Rs.)</label>
                            <form action="${pageContext.request.contextPath}/classrooms/manage" method="POST" style="display:flex; gap:10px; align-items:center;">
                                <input type="hidden" name="action" value="updatePrice">
                                <input type="hidden" name="classId" value="${classroom.id}">
                                <input type="number" name="newPrice" class="price-input" value="${price}" min="0" step="0.01" style="padding:10px; border-radius:6px; border:1px solid #cbd5e1; flex:1; font-size:1rem; font-weight:600;">
                                <button type="submit" style="background:#10b981; color:white; border:none; padding:10px 20px; border-radius:6px; cursor:pointer; font-weight:600; transition: background 0.2s;">Save Price</button>
                            </form>
                        </div>
                    </div>

                    <div class="classroom-right-col">
                        <div class="subjects-table-card">
                            <div class="subjects-table-header" style="display:flex; justify-content:space-between; border-bottom:2px solid #e2e8f0; padding-bottom:10px; margin-bottom:10px; font-weight:600;">
                                <span>Subject</span>
                                <span>Action</span>
                            </div>
                            
                            <c:forEach var="subject" items="${subjects}">
                                <div class="subjects-table-row" style="display:flex; justify-content:space-between; align-items:center; padding: 12px 0; border-bottom: 1px solid #f1f5f9;">
                                    <span style="font-weight:500; color:#334155;">${subject}</span>
                                    <form action="${pageContext.request.contextPath}/classrooms/manage" method="POST" style="margin:0;">
                                        <input type="hidden" name="action" value="deleteSubject">
                                        <input type="hidden" name="classId" value="${classroom.id}">
                                        <input type="hidden" name="subjectName" value="${subject}">
                                        <button type="submit" style="background:#ef4444; color:white; border:none; padding:6px 12px; border-radius:4px; cursor:pointer; font-size:0.85rem;" onclick="return confirm('Are you sure you want to remove this subject?');">Delete</button>
                                    </form>
                                </div>
                            </c:forEach>
                            
                            <div class="subjects-table-add" style="margin-top:20px;">
                                <form action="${pageContext.request.contextPath}/classrooms/manage" method="POST" style="display:flex; gap:10px;">
                                    <input type="hidden" name="action" value="addSubject">
                                    <input type="hidden" name="classId" value="${classroom.id}">
                                    <input type="text" name="subjectName" placeholder="Enter new subject name" required style="flex:1; padding:10px; border-radius:6px; border:1px solid #cbd5e1;">
                                    <button type="submit" style="background:#3b82f6; color:white; border:none; padding:10px 20px; border-radius:6px; cursor:pointer; font-weight:600;">Add Subject</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>
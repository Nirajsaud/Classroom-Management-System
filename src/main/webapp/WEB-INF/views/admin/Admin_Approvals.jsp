<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Approvals – Pathshala</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin_Students.css">
    <style>
        /* Specific styles for the action buttons */
        .action-btn { padding: 0.5rem 1rem; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 0.85rem; transition: background-color 0.2s; }
        .btn-approve { background-color: #d1fae5; color: #065f46; }
        .btn-approve:hover { background-color: #a7f3d0; }
        .btn-reject { background-color: #fee2e2; color: #991b1b; }
        .btn-reject:hover { background-color: #fecaca; }
        .action-forms-wrapper { display: flex; gap: 10px; }
    </style>
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
            <a href="${pageContext.request.contextPath}/classrooms" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
                <span>Classrooms</span>
            </a>
            <a href="${pageContext.request.contextPath}/report" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg>
                <span>Report</span>
            </a>
        </nav>
    </aside>

    <div class="main-area">
        <header class="topbar">
            <div class="bell-wrapper">
                <a href="${pageContext.request.contextPath}/approvals" class="bell-btn" title="Pending Approvals" style="display: flex; align-items: center; text-decoration: none; position: relative;">
                    <svg class="bell-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:24px; height:24px; color:#111827;"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
                    <c:if test="${pendingCount > 0}">
                        <span class="bell-badge" style="position: absolute; top: -2px; right: -2px; width: 10px; height: 10px; background: #ef4444; border-radius: 50%;"></span>
                    </c:if>
                </a>
            </div>
            <div class="topbar-divider"></div>
            <a href="${pageContext.request.contextPath}/profile" class="user-avatar" title="Admin Profile">
                <img src="https://via.placeholder.com/80" alt="Admin Profile">
            </a>
            <a href="${pageContext.request.contextPath}/logout-user" class="logout-btn" style="text-decoration: none;">Logout</a>
        </header>

        <main class="content-area">
            <div class="page-header">
                <div>
                    <h1 class="page-title-large">Pending Approvals</h1>
                    <p class="page-subtitle">Review and authorize new user registrations for system access.</p>
						<c:if test="${param.status eq 'success'}">
							<div
								style="padding: 1rem; margin-top: 1rem; background-color: #d1fae5; color: #065f46; border-radius: 8px; font-weight: 500;">
								Account successfully ${param.action eq 'approve' ? 'approved and activated' : 'rejected and deleted'}.
							</div>
						</c:if>
						<c:if
							test="${param.status eq 'failed' || param.status eq 'error'}">
							<div
								style="padding: 1rem; margin-top: 1rem; background-color: #fee2e2; color: #991b1b; border-radius: 8px; font-weight: 500;">
								An error occurred while processing the request. Please try
								again.</div>
						</c:if>
					</div>
            </div>

            <section class="teacher-table-card" style="margin-top: 2rem;">
                <div class="filter-row">
                    <div class="table-total" style="font-weight: 600; font-size: 1.1rem;">Total Pending : ${pendingCount}</div>
                </div>

                <div class="table-header-row" style="grid-template-columns: 2fr 1fr 1fr 1fr;">
                    <div>Name</div>
                    <div>Requested Role</div>
                    <div>Time</div>
                    <div>Actions</div>
                </div>

                <c:choose>
                    <c:when test="${empty pendingApprovals}">
                        <div style="text-align: center; padding: 4rem 2rem; color: #64748b;">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" width="48" height="48" style="margin-bottom: 1rem; opacity: 0.5;">
                                <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/>
                            </svg>
                            <p style="font-size: 1.2rem; font-weight: 600; margin-bottom: 0.25rem;">All caught up!</p>
                            <p style="font-size: 0.9rem;">There are no active account requests pending your approval.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="req" items="${pendingApprovals}">
                            <div class="teacher-row" style="grid-template-columns: 2fr 1fr 1fr 1fr;">
                                <div class="teacher-name">
                                    <span class="avatar-gray">${fn:toUpperCase(fn:substring(req.fullName, 0, 1))}</span>
                                    <span style="font-weight: 600;"><c:out value="${req.fullName}"/></span>
                                </div>
                                <div style="color: #64748b; font-weight: 500;"><c:out value="${req.role}"/></div>
                                <div style="color: #64748b; font-size: 0.9rem;"><c:out value="${req.timeAgo}"/></div>
                                <div class="action-forms-wrapper">
                                    <form action="${pageContext.request.contextPath}/admin/approval" method="POST">
                                        <input type="hidden" name="userId" value="${req.userId}">
                                        <input type="hidden" name="action" value="approve">
                                        <button type="submit" class="action-btn btn-approve">Approve</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/approval" method="POST">
                                        <input type="hidden" name="userId" value="${req.userId}">
                                        <input type="hidden" name="action" value="reject">
                                        <button type="submit" class="action-btn btn-reject">Reject</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </section>
        </main>
    </div>
</div>
</body>
</html>
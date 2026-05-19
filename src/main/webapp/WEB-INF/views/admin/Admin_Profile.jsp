<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile – Pathshala</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin_Profile.css">
</head>
<body>

<div class="app-wrapper">

    <!-- ═══════════════ SIDEBAR ═══════════════ -->
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

            <a href="${pageContext.request.contextPath}/teachers" class="nav-item">
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

    <!-- ═══════════════ MAIN ═══════════════ -->
    <div class="main-area">

        <!-- Topbar -->
        <header class="topbar">

            <div class="bell-wrapper" id="bellWrapper">
                <button class="bell-btn" id="bellBtn" title="Notifications" aria-haspopup="true" aria-expanded="false">
                    <svg class="bell-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/>
                        <path d="M13.73 21a2 2 0 0 1-3.46 0"/>
                    </svg>
                </button>
                <span class="bell-badge" id="bellBadge"></span>

                <div class="notif-dropdown" id="notifDropdown" role="menu">
                    <div class="notif-header">
                        <h4>Login Approvals</h4>
                        <button class="notif-mark-all" id="markAllRead">Dismiss all</button>
                    </div>
                    <div class="notif-list" id="notifList">

                        <div class="notif-item unread" role="menuitem">
                            <div class="notif-dot"></div>
                            <div class="notif-content">
                                <div class="notif-text"><strong>Aarav Sharma</strong> (Class 8) is requesting login access.</div>
                                <div class="notif-time">Just now</div>
                                <div class="notif-actions">
                                    <button class="btn-approve">Approve</button>
                                    <button class="btn-reject">Reject</button>
                                </div>
                            </div>
                        </div>

                        <div class="notif-item unread" role="menuitem">
                            <div class="notif-dot"></div>
                            <div class="notif-content">
                                <div class="notif-text"><strong>Priya Thapa</strong> (Class 6) is requesting login access.</div>
                                <div class="notif-time">3 minutes ago</div>
                                <div class="notif-actions">
                                    <button class="btn-approve">Approve</button>
                                    <button class="btn-reject">Reject</button>
                                </div>
                            </div>
                        </div>

                        <div class="notif-item unread" role="menuitem">
                            <div class="notif-dot"></div>
                            <div class="notif-content">
                                <div class="notif-text"><strong>Rohan Karki</strong> (Class 10) is requesting login access.</div>
                                <div class="notif-time">10 minutes ago</div>
                                <div class="notif-actions">
                                    <button class="btn-approve">Approve</button>
                                    <button class="btn-reject">Reject</button>
                                </div>
                            </div>
                        </div>

                        <div class="notif-item unread" role="menuitem">
                            <div class="notif-dot"></div>
                            <div class="notif-content">
                                <div class="notif-text"><strong>Sita Gurung</strong> (Class 5) is requesting login access.</div>
                                <div class="notif-time">25 minutes ago</div>
                                <div class="notif-actions">
                                    <button class="btn-approve">Approve</button>
                                    <button class="btn-reject">Reject</button>
                                </div>
                            </div>
                        </div>

                        <div class="notif-item unread" role="menuitem">
                            <div class="notif-dot"></div>
                            <div class="notif-content">
                                <div class="notif-text"><strong>Bikash Rai</strong> (Class 9) is requesting login access.</div>
                                <div class="notif-time">1 hour ago</div>
                                <div class="notif-actions">
                                    <button class="btn-approve">Approve</button>
                                    <button class="btn-reject">Reject</button>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="notif-footer" id="notifEmpty" style="display:none;">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" width="32" height="32">
                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
                            <polyline points="22 4 12 14.01 9 11.01"/>
                        </svg>
                        <p>All caught up!</p>
                    </div>
                </div>
            </div>

            <div class="topbar-divider"></div>

            <a href="${pageContext.request.contextPath}/adminprofile" class="user-avatar" title="Admin Profile">
			    <img src="https://via.placeholder.com/80" alt="Admin profile placeholder">
			</a>

            <a href="${pageContext.request.contextPath}/logout-user"
               class="logout-btn"
               style="text-decoration: none; display: inline-flex; align-items: center; justify-content: center;">
                Logout
            </a>

        </header>

        <!-- ═══════════════ PROFILE CONTENT ═══════════════ -->
        <main class="content-area">

            <h1 class="profile-page-title">Admin Profile</h1>

            <form class="profile-card"
                  action="${pageContext.request.contextPath}/admin/updateProfile"
                  method="post"
                  enctype="multipart/form-data">

                <!-- Left: Photo -->
                <div class="profile-photo-col">
                    <div class="profile-photo-wrap">
                        <img src="${not empty adminPhoto
                                    ? pageContext.request.contextPath.concat('/').concat(adminPhoto)
                                    : 'https://via.placeholder.com/160'}"
                             alt="Admin Photo"
                             class="profile-photo">
                        <label class="photo-edit-btn" for="photoInput" title="Change photo">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                 stroke-linecap="round" stroke-linejoin="round">
                                <path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8
                                         a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"/>
                                <circle cx="12" cy="13" r="4"/>
                            </svg>
                        </label>
                        <input type="file" id="photoInput" name="adminPhoto" accept="image/*">
                    </div>
                </div>

                <!-- Right: Form -->
                <div class="profile-form-col">

                    <div class="profile-section-heading">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                             stroke-linecap="round" stroke-linejoin="round" width="18" height="18">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                            <circle cx="12" cy="7" r="4"/>
                        </svg>
                        <span>Personal Details</span>
                    </div>

                    <div class="profile-fields">
                        <div class="profile-field-group">
                            <label class="field-label" for="fullName">FULL NAME</label>
                            <input class="field-input" type="text" id="fullName"
                                name="fullName"
                                placeholder="${adminFullNamePlaceholder}"
                                value="${adminFullName}">
                        </div>
                        <div class="profile-field-group">
                            <label class="field-label" for="phoneNumber">PHONE NUMBER</label>
                            <input class="field-input" type="tel" id="phoneNumber"
                                name="phoneNumber"
                                placeholder="${adminPhonePlaceholder}"
                                value="${adminPhone}">
                        </div>

                        <div class="profile-field-group">
                            <label class="field-label" for="email">EMAIL</label>
                            <input class="field-input" type="email" id="email"
                                name="email"
                                placeholder="${adminEmailPlaceholder}"
                                value="${adminEmail}">
                        </div>

                    </div>

                    <div class="profile-actions">
                        <button class="btn-cancel-changes" type="reset">Cancel Changes</button>
                        <button class="btn-save-changes"   type="submit">Save Changes</button>
                    </div>

                </div>
            </form>

        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/Admin_Profile.js"></script>
</body>
</html>
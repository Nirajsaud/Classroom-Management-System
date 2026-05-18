<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students – Pathshala</title>
    <link rel="stylesheet" href="../css/Admin_Students.css">
</head>
<body>

<div class="app-wrapper">

    <!-- ═══════════════ SIDEBAR ═══════════════ -->
    <aside class="sidebar">
        <div class="sidebar-logo">pathshala</div>
        <nav class="sidebar-nav">

            <a href="Admin_Dashboard.jsp" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="3" width="7" height="7" rx="1"/>
                    <rect x="14" y="3" width="7" height="7" rx="1"/>
                    <rect x="3" y="14" width="7" height="7" rx="1"/>
                    <rect x="14" y="14" width="7" height="7" rx="1"/>
                </svg>
                <span>Dashboard</span>
            </a>

            <a href="Admin_Teacher.jsp" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M22 10v6M2 10l10-5 10 5-10 5z"/>
                    <path d="M6 12v5c3 3 9 3 12 0v-5"/>
                </svg>
                <span>Teachers</span>
            </a>

            <a href="Admin_Student.jsp" class="nav-item active">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                    <circle cx="9" cy="7" r="4"/>
                    <path d="M23 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/>
                </svg>
                <span>Students</span>
            </a>

            <a href="Admin_Classroom.jsp" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                    <polyline points="9 22 9 12 15 12 15 22"/>
                </svg>
                <span>Classrooms</span>
            </a>

            <a href="Admin_Report.jsp" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                    <polyline points="14 2 14 8 20 8"/>
                    <line x1="16" y1="13" x2="8" y2="13"/>
                    <line x1="16" y1="17" x2="8" y2="17"/>
                    <polyline points="10 9 9 9 8 9"/>
                </svg>
                <span>Report</span>
            </a>

            <a href="Admin_Contact.jsp" class="nav-item">
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

            <div class="user-avatar" title="Admin Profile">
                <img src="https://via.placeholder.com/80" alt="Admin profile placeholder">
            </div>

            <button type="button" class="logout-btn">Logout</button>
        </header>

        <!-- Content -->
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
                    <span class="teacher-stat-value">4</span>
                </div>
            </div>

            <section class="teacher-table-card">
                <div class="filter-row">
                    <div class="filter-select">
                        <select>
                            <option>All Students</option>
                            <option>Class 4</option>
                            <option>Class 5</option>
                            <option>Class 6</option>
                            <option>Class 7</option>
                            <option>Class 8</option>
                            <option>Class 9</option>
                            <option>Class 10</option>
                        </select>
                    </div>
                    <div class="table-total">Total : 4</div>
                </div>

                <div class="table-header-row">
                    <div>Name</div>
                    <div>Email</div>
                    <div>Phone No.</div>
                    <div>Action</div>
                </div>

                <div class="teacher-row">
                    <div class="teacher-name"><span class="avatar-gray">S</span><span>Sabin Paudel</span></div>
                    <div>sabin.paudel@pathshala.edu</div>
                    <div>9843304801</div>
                    <div>
                        <a class="view-link"
                           href="Admin_Student_View.jsp?name=Sabin+Paudel&email=sabin.paudel%40pathshala.edu&phone=9843304801&classrooms=Class+4,Class+7&lastLogin=2026-05-13%2C+03%3A54+PM">
                            View
                        </a>
                    </div>
                </div>

                <div class="teacher-row">
                    <div class="teacher-name"><span class="avatar-gray">N</span><span>Nischal Raj Joshi</span></div>
                    <div>nischal.joshi@pathshala.edu</div>
                    <div>9767965747</div>
                    <div>
                        <a class="view-link"
                           href="Admin_Student_View.jsp?name=Nischal+Raj+Joshi&email=nischal.joshi%40pathshala.edu&phone=9767965747&classrooms=Class+5,Class+8&lastLogin=2026-05-12%2C+02%3A15+PM">
                            View
                        </a>
                    </div>
                </div>

                <div class="teacher-row">
                    <div class="teacher-name"><span class="avatar-gray">K</span><span>Kritika Basel</span></div>
                    <div>kritika.basel@pathshala.edu</div>
                    <div>9765417252</div>
                    <div>
                        <a class="view-link"
                           href="Admin_Student_View.jsp?name=Kritika+Basel&email=kritika.basel%40pathshala.edu&phone=9765417252&classrooms=Class+6,Class+9&lastLogin=2026-05-10%2C+01%3A30+PM">
                            View
                        </a>
                    </div>
                </div>

                <div class="teacher-row">
                    <div class="teacher-name"><span class="avatar-gray">N</span><span>Niraj Saud</span></div>
                    <div>niraj.saud@pathshala.edu</div>
                    <div>9869357800</div>
                    <div>
                        <a class="view-link"
                           href="Admin_Student_View.jsp?name=Niraj+Saud&email=niraj.saud%40pathshala.edu&phone=9869357800&classrooms=Class+4,Class+7&lastLogin=2026-05-13%2C+03%3A54+PM">
                            View
                        </a>
                    </div>
                </div>

                <div class="table-pagination" id="studentPagination"></div>
            </section>

        </main>
    </div>
</div>

<script src="../js/Admin_Students.js"></script>
</body>
</html>
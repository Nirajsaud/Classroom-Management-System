<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classrooms – Pathshala</title>
    <link rel="stylesheet" href="../css/Admin_Classroom.css">
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

            <a href="Admin_Student.jsp" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                    <circle cx="9" cy="7" r="4"/>
                    <path d="M23 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/>
                </svg>
                <span>Students</span>
            </a>

            <a href="Admin_Classroom.jsp" class="nav-item active">
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
                    <h1 class="page-title-large">Classroom Directory</h1>
                    <p class="page-subtitle">View and manage all Classrooms</p>
                </div>
            </div>

            <section class="teacher-table-card">
                <div class="table-header-row">
                    <div>Classroom</div>
                    <div>Price</div>
                    <div>Total Students</div>
                    <div>Action</div>
                </div>

                <div class="teacher-row">
                    <div>Class 4</div>
                    <div>Rs. 2000</div>
                    <div>25</div>
                    <div>
                        <a class="manage-link"
                           href="Admin_Classroom_Manage.jsp?className=Class+4&students=25&price=2000&subjects=Maths%7CNiraj+Saud%3BScience%7CKritika+Basel%3BEnglish%7CNischal+Raj+Joshi%3BSocial+Studies%7C-%3BNepali%7CSabin+Paudel">
                            Manage
                        </a>
                    </div>
                </div>

                <div class="teacher-row">
                    <div>Class 5</div>
                    <div>Rs. 3500</div>
                    <div>109</div>
                    <div>
                        <a class="manage-link"
                           href="Admin_Classroom_Manage.jsp?className=Class+5&students=109&price=3500&subjects=Maths%7C-%3BScience%7C-%3BEnglish%7C-%3BSocial+Studies%7C-%3BNepali%7C-">
                            Manage
                        </a>
                    </div>
                </div>

                <div class="teacher-row">
                    <div>Class 6</div>
                    <div>Rs. 3500</div>
                    <div>293</div>
                    <div>
                        <a class="manage-link"
                           href="Admin_Classroom_Manage.jsp?className=Class+6&students=293&price=3500&subjects=Maths%7C-%3BScience%7C-%3BEnglish%7C-%3BSocial+Studies%7C-%3BNepali%7C-">
                            Manage
                        </a>
                    </div>
                </div>

                <div class="teacher-row">
                    <div>Class 7</div>
                    <div>Rs. 4000</div>
                    <div>67</div>
                    <div>
                        <a class="manage-link"
                           href="Admin_Classroom_Manage.jsp?className=Class+7&students=67&price=4000&subjects=Maths%7C-%3BScience%7C-%3BEnglish%7C-%3BSocial+Studies%7C-%3BNepali%7C-">
                            Manage
                        </a>
                    </div>
                </div>

                <div class="teacher-row">
                    <div>Class 8</div>
                    <div>Rs. 6500</div>
                    <div>469</div>
                    <div>
                        <a class="manage-link"
                           href="Admin_Classroom_Manage.jsp?className=Class+8&students=469&price=6500&subjects=Maths%7C-%3BScience%7C-%3BEnglish%7C-%3BSocial+Studies%7C-%3BNepali%7C-">
                            Manage
                        </a>
                    </div>
                </div>

                <div class="teacher-row">
                    <div>Class 9</div>
                    <div>Rs. 6500</div>
                    <div>438</div>
                    <div>
                        <a class="manage-link"
                           href="Admin_Classroom_Manage.jsp?className=Class+9&students=438&price=6500&subjects=Maths%7C-%3BScience%7C-%3BEnglish%7C-%3BSocial+Studies%7C-%3BNepali%7C-">
                            Manage
                        </a>
                    </div>
                </div>

                <div class="teacher-row">
                    <div>Class 10</div>
                    <div>Rs. 8000</div>
                    <div>390</div>
                    <div>
                        <a class="manage-link"
                           href="Admin_Classroom_Manage.jsp?className=Class+10&students=390&price=8000&subjects=Maths%7C-%3BScience%7C-%3BEnglish%7C-%3BSocial+Studies%7C-%3BNepali%7C-">
                            Manage
                        </a>
                    </div>
                </div>

            </section>

        </main>
    </div>
</div>

<script src="../js/Admin_Classroom.js"></script>
</body>
</html>
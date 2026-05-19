<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin_Teacher – Pathshala</title>
    <link rel="stylesheet" href="../css/Admin_Contact.css">
</head>
<body>

<div class="app-wrapper">

    <!-- ═══════════════ SIDEBAR ═══════════════ -->
    <aside class="sidebar">
        <div class="sidebar-logo">pathshala</div>

        <nav class="sidebar-nav">

            <a href="#" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="3" width="7" height="7" rx="1"/>
                    <rect x="14" y="3" width="7" height="7" rx="1"/>
                    <rect x="3" y="14" width="7" height="7" rx="1"/>
                    <rect x="14" y="14" width="7" height="7" rx="1"/>
                </svg>
                <span>Dashboard</span>
            </a>

            <a href="#" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M22 10v6M2 10l10-5 10 5-10 5z"/>
                    <path d="M6 12v5c3 3 9 3 12 0v-5"/>
                </svg>
                <span>Teachers</span>
            </a>

            <a href="#" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                    <circle cx="9" cy="7" r="4"/>
                    <path d="M23 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/>
                </svg>
                <span>Students</span>
            </a>

            <a href="#" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                    <polyline points="9 22 9 12 15 12 15 22"/>
                </svg>
                <span>Classrooms</span>
            </a>

            <a href="#" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                    <polyline points="14 2 14 8 20 8"/>
                    <line x1="16" y1="13" x2="8" y2="13"/>
                    <line x1="16" y1="17" x2="8" y2="17"/>
                    <polyline points="10 9 9 9 8 9"/>
                </svg>
                <span>Report</span>
            </a>

            <a href="#" class="nav-item active">
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
                                <div class="notif-text">
                                    <strong>Aarav Sharma</strong> (Class 8) is requesting login access.
                                </div>
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
                                <div class="notif-text">
                                    <strong>Priya Thapa</strong> (Class 6) is requesting login access.
                                </div>
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
                                <div class="notif-text">
                                    <strong>Rohan Karki</strong> (Class 10) is requesting login access.
                                </div>
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
                                <div class="notif-text">
                                    <strong>Sita Gurung</strong> (Class 5) is requesting login access.
                                </div>
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
                                <div class="notif-text">
                                    <strong>Bikash Rai</strong> (Class 9) is requesting login access.
                                </div>
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

            <a href="${pageContext.request.contextPath}/logout-user" class="logout-btn" style="text-decoration: none; display: inline-flex; align-items: center; justify-content: center;">Logout</a>


        </header>
        <div class="submission-container">
    
    <div class="submission-header">
        <div class="title-block">
            <h1>Contact Submission</h1>
            <p>Review and manage inquiries sent through the Pathshala platform</p>
        </div>
    </div>

    <div class="submission-card">
        <div class="table-wrapper">
            <table class="styled-table">
                <thead>
                    <tr>
                        <th width="15%">Date / Time</th>
                        <th width="25%">Sender Details</th>
                        <th width="20%">Phone Number</th>
                        <th width="25%">Message Snippet</th>
                        <th width="15%" class="text-right">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    
                    <tr class="main-row unread">
                        <td>
                            <div class="date-txt">18 May 2026</div>
                            <div class="time-txt">04:15 PM</div>
                        </td>
                        <td>
                            <div class="user-name">Bikash Rai</div>
                            <div class="user-email">bikash.rai@example.com</div>
                        </td>
                        <td><span class="phone-tag">9841234567</span></td>
                        <td>
                            <p class="msg-preview">I'm having trouble logging into the Class 9 math portal...</p>
                        </td>
                        <td class="text-right">
                            <div class="action-group">
                                <button class="tbl-btn toggle-msg-btn" type="button">Open</button>
                                <button class="tbl-btn bin-btn" type="button" title="Delete Submission">Bin</button>
                            </div>
                        </td>
                    </tr>
                    <tr class="detail-row">
                        <td colspan="5">
                            <div class="detail-content">
                                <h5>Full Message Content:</h5>
                                <p>I'm having trouble logging into the Class 9 math portal. It keeps throwing a credential error. Can you please reset my password or verify if my account is activated for this term? Cheers.</p>
                            </div>
                        </td>
                    </tr>

                    <tr class="main-row">
                        <td>
                            <div class="date-txt">17 May 2026</div>
                            <div class="time-txt">11:30 AM</div>
                        </td>
                        <td>
                            <div class="user-name">Sita Gurung</div>
                            <div class="user-email">sita.g@gmail.com</div>
                        </td>
                        <td><span class="phone-tag">9800000000</span></td>
                        <td>
                            <p class="msg-preview">The user interface updates look spot on! Much cleaner...</p>
                        </td>
                        <td class="text-right">
                            <div class="action-group">
                                <button class="tbl-btn toggle-msg-btn" type="button">Open</button>
                                <button class="tbl-btn bin-btn" type="button" title="Delete Submission">Bin</button>
                            </div>
                        </td>
                    </tr>
                    <tr class="detail-row">
                        <td colspan="5">
                            <div class="detail-content">
                                <h5>Full Message Content:</h5>
                                <p>The user interface updates look spot on! Much cleaner than the older version. The sidebar transitions are smooth and everything feels much snappier. Brilliant work by the engineering division.</p>
                            </div>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
    </div>

</div>
    </div>
</div>

<script src="../js/Admin_Contact.js"></script>
</body>
</html>
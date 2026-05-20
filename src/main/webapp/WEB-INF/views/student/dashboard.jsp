<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Student Dashboard</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentDashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notification.css">

    <style type="text/css">
        @font-face {
            font-family: 'Ananda Namaste';
            src: url('${pageContext.request.contextPath}/fonts/ananda-namaste.ttf') format('truetype');
        }

        header.main-nav, header.main-nav * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        header.main-nav {
            background: #FFFFFF !important;
            height: 58px !important;
            display: flex !important;
            align-items: center !important;
            border-bottom: 1px solid #E2E8F0 !important;
            padding: 0 4rem !important;
            width: 100% !important;
            position: relative !important;
            z-index: 9999 !important;
        }

        header.main-nav .nav-container {
            width: 100% !important;
            display: flex !important;
            justify-content: space-between !important;
            align-items: center !important;
        }

        header.main-nav .logo-area {
            display: flex !important;
            align-items: center !important;
        }

        header.main-nav .pathshala-logo {
            font-family: 'Ananda Namaste', cursive !important;
            font-size: 1.65rem !important;
            color: #000000 !important;
            text-decoration: none !important;
        }

        header.main-nav .center-links {
            display: flex !important;
            gap: 1.6rem !important;
            align-items: center !important;
            list-style: none !important;
        }

        header.main-nav .nav-link {
            color: #94A3B8 !important;
            font-weight: 500 !important;
            font-size: 0.9rem !important;
            display: flex !important;
            align-items: center !important;
            gap: 7px !important;
            text-decoration: none !important;
            transition: color 0.2s !important;
        }

        header.main-nav .nav-link.active,
        header.main-nav .nav-link:hover {
            color: #1E3A8A !important;
        }

        header.main-nav .user-controls {
            display: flex !important;
            align-items: center !important;
            gap: 1.1rem !important;
        }

        header.main-nav .v-divider {
            width: 1px !important;
            height: 30px !important;
            background: #E2E8F0 !important;
            display: block !important;
        }

        header.main-nav .profile-icon {
            width: 38px !important;
            height: 38px !important;
            border-radius: 50% !important;
            overflow: hidden !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            background: #f3f4f6 !important;
            text-decoration: none !important;
        }

        header.main-nav .nav-profile-image {
            width: 100% !important;
            height: 100% !important;
            object-fit: cover !important;
            border-radius: 50% !important;
        }

        header.main-nav .default-profile-icon {
            display: none;
            align-items: center;
            justify-content: center;
            width: 100%;
            height: 100%;
            color: #64748B;
        }

        header.main-nav .logout-btn {
            color: #EF4444 !important;
            font-size: 0.8rem !important;
            font-weight: 600 !important;
            text-decoration: none !important;
        }

        @media (max-width: 900px) {
            header.main-nav {
                height: auto !important;
                padding: 1rem 1.5rem !important;
            }

            header.main-nav .nav-container {
                flex-direction: column !important;
                gap: 1rem !important;
            }
        }
    </style>
</head>
<body>

<header class="main-nav">
    <div class="nav-container">
        <div class="logo-area">
            <span class="pathshala-logo">pathshala</span>
        </div>

        <nav class="center-links">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link active">
                <i class="fa-solid fa-table-cells-large"></i> Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/classrooms" class="nav-link">
                <i class="fa-solid fa-pen-nib"></i> Classrooms
            </a>

            <a href="${pageContext.request.contextPath}/subjects" class="nav-link">
                <i class="fa-solid fa-book"></i> Subjects
            </a>

            <a href="${pageContext.request.contextPath}/payment" class="nav-link">
                <i class="fa-solid fa-wallet"></i> Payment
            </a>
        </nav>

        <div class="user-controls">
            <div class="bell-wrapper" id="bellWrapper">
                <button type="button" class="bell-btn" id="bellBtn">
                    <i class="fa-regular fa-bell"></i>
                </button>

                <c:if test="${not empty noticeList}">
                    <span class="bell-badge" id="bellBadge"></span>
                </c:if>

                <div class="notif-dropdown" id="notifDropdown">
                    <div class="notif-header">
                        <h4>Notifications</h4>
                        <button type="button" class="notif-mark-all" id="markAllRead">Dismiss all</button>
                    </div>

                    <div class="notif-list" id="notifList">
                        <c:choose>
                            <c:when test="${empty noticeList}">
                                <div class="notif-footer">
                                    <p>No notifications yet.</p>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <c:forEach var="notice" items="${noticeList}">
                                    <div class="notif-item unread">
                                        <div class="notif-dot"></div>

                                        <div class="notif-content">
                                            <div class="notif-title">${notice.title}</div>
                                            <div class="notif-text">${notice.content}</div>
                                            <div class="notif-time">${notice.createdAt}</div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="v-divider"></div>

            <a href="${pageContext.request.contextPath}/profile" class="profile-icon">
                <img src="${pageContext.request.contextPath}/getimage?name=${user.email}"
                     alt="Profile"
                     class="nav-profile-image"
                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">

                <div class="default-profile-icon">
                    <i class="fa-solid fa-user"></i>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/logout-user" class="logout-btn">Logout</a>
        </div>
    </div>
</header>

<main class="dashboard-container">

    <header class="welcome-section">
        <h1>Welcome Back, <span class="underlined-name">${user.fullName}</span></h1>
        <p>What would you like to do today?</p>
    </header>

    <section class="action-grid">
        <a href="${pageContext.request.contextPath}/subjects" class="card card-subjects">
            <div class="card-header">
                <h2>Subjects</h2>
            </div>
            <div class="card-body">
                <p>View and access materials from the classrooms you have enrolled in.</p>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/classrooms" class="card card-classrooms">
            <div class="card-header">
                <h2>Classrooms</h2>
            </div>
            <div class="card-body">
                <p>Browse available classroom packages from Grade 4 to 10 and purchase the ones you want to join.</p>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/payment" class="card card-payments">
            <div class="card-header">
                <h2>My Payments</h2>
            </div>
            <div class="card-body">
                <p>Check your payments, expiry dates, and renew classroom subscriptions.</p>
            </div>
        </a>
    </section>

    <section class="notification-panel">
        <div class="notif-title">
            <h2>Notification</h2>
        </div>

        <div class="notif-content">
            <c:choose>
                <c:when test="${empty noticeList}">
                    <div class="notif-row">
                        <span class="timestamp">No notices yet</span>
                        <p class="message">New classroom updates and study materials will appear here.</p>
                    </div>
                </c:when>

                <c:otherwise>
                    <c:forEach var="notice" items="${noticeList}">
                        <div class="notif-row">
                            <span class="timestamp">${notice.createdAt}</span>
                            <p class="message">
                                <strong>${notice.title}</strong><br>
                                ${notice.content}
                            </p>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

</main>

<script src="${pageContext.request.contextPath}/js/notification.js"></script>
</body>
</html>
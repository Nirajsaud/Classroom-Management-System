<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Student Payment</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentPayment.css">
        <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/notification.css">
</head>
<body>

<header class="main-nav">
    <div class="nav-container">
        <div class="logo-area">
            <span class="pathshala-logo">pathshala</span>
        </div>

        <nav class="center-links">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                <i class="fa-solid fa-table-cells-large"></i> Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/classrooms" class="nav-link">
                <i class="fa-solid fa-pen-nib"></i> Classrooms
            </a>

            <a href="${pageContext.request.contextPath}/subjects" class="nav-link">
                <i class="fa-solid fa-book"></i> Subjects
            </a>

            <a href="${pageContext.request.contextPath}/payments" class="nav-link active">
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
                <button type="button" class="notif-mark-all" id="markAllRead">
                    Dismiss all
                </button>
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

    <a href="${pageContext.request.contextPath}/profile"
   class="profile-icon">

    <img src="${pageContext.request.contextPath}/getimage?name=${user.email}"
         alt="Profile"
         class="nav-profile-image"

         onerror="this.style.display='none';
                  this.nextElementSibling.style.display='flex';">

    <div class="default-profile-icon">
        <i class="fa-solid fa-user"></i>
    </div>

</a>

    <a href="${pageContext.request.contextPath}/logout-user" class="logout-btn">Logout</a>

</div>
</div>
</header>

<main class="payment-page">

    <section class="payment-header">
        <h1>My Payments</h1>
        <p>View your completed classroom payments and enrolled class packages.</p>
    </section>

    <section class="summary-grid">
        <div class="summary-card">
            <i class="fa-solid fa-wallet"></i>
            <div>
                <h3>Total Paid</h3>
                <p>Rs. ${totalPaid}</p>
            </div>
        </div>

        <div class="summary-card">
            <i class="fa-solid fa-book-open-reader"></i>
            <div>
                <h3>Active Classes</h3>
                <p>${activeClassCount} Classes</p>
            </div>
        </div>

        <div class="summary-card">
            <i class="fa-solid fa-receipt"></i>
            <div>
                <h3>Payment Records</h3>
                <p>${fn:length(paymentList)} Payments</p>
            </div>
        </div>
    </section>

    <section class="payment-table-card">
        <div class="table-title">
            <h2>Payment History</h2>
            <span>Completed transactions from your enrolled classrooms</span>
        </div>

        <c:choose>
            <c:when test="${empty paymentList}">
                <div class="empty-payment">
                    <i class="fa-regular fa-folder-open"></i>
                    <h3>No payments found</h3>
                    <p>Your completed payments will appear here after you buy a classroom package.</p>
                </div>
            </c:when>

            <c:otherwise>
                <div class="table-wrapper">
                    <table class="payment-table">
                        <thead>
                            <tr>
                                <th>Classroom</th>
                                <th>Amount Paid</th>
                                <th>Payment Method</th>
                                <th>Payment Date</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="payment" items="${paymentList}">
                                <tr>
                                    <td>${payment.className}</td>
                                    <td>Rs. ${payment.amountPaid}</td>
                                    <td>${payment.paymentMethod}</td>
                                    <td>${payment.paymentDate}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

</main>
<script src="${pageContext.request.contextPath}/js/notification.js"></script>
</body>
</html>
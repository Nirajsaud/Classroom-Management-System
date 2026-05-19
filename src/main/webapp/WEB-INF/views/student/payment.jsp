<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Payment</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/payment.css">
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

            <a href="${pageContext.request.contextPath}/classrooms" class="nav-link active">
                <i class="fa-solid fa-pen-nib"></i> Classrooms
            </a>

            <a href="${pageContext.request.contextPath}/subjects" class="nav-link">
                <i class="fa-solid fa-book"></i> Subjects
            </a>


            <a href="${pageContext.request.contextPath}/payments" class="nav-link">

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

    <section class="payment-card">
        <h1>Confirm Payment</h1>

        <p class="payment-text">
            Review your classroom package before continuing.
        </p>

        <div class="payment-summary">
            <div class="summary-row">
                <span>Classroom</span>
                <strong>${selectedClass.className}</strong>
            </div>

            <div class="summary-row">
                <span>Price</span>
                <strong>Rs. ${selectedClass.price}</strong>
            </div>

            <div class="summary-row">
                <span>Payment Date</span>
                <strong>${currentDate}</strong>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/makepayment" method="post">

            <input type="hidden" name="classId" value="${selectedClass.classId}">
            <input type="hidden" name="amountPaid" value="${selectedClass.price}">
            <input type="hidden" name="paymentDate" value="${currentDate}">

            <div class="form-group">
                <label for="paymentMethod">PAYMENT METHOD</label>

                <select id="paymentMethod" name="paymentMethod" required>
                    <option value="Esewa">Esewa</option>
                    <option value="Khalti">Khalti</option>
                    <option value="Cash">Cash</option>
                </select>
            </div>

            <button type="submit" class="pay-btn">Pay Now</button>
        </form>
    </section>

</main>
<script src="${pageContext.request.contextPath}/js/notification.js"></script>
</body>
</html>
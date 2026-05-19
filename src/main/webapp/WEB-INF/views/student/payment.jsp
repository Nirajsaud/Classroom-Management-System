<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Payment</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/payment.css">
</head>
<body>

<header class="main-nav">
    <div class="nav-container">
        <div class="logo-area">
            <span class="pathshala-logo">pathshala</span>
        </div>

        <nav class="center-links">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/student/classroom" class="nav-link">Classrooms</a>
            <a href="${pageContext.request.contextPath}/student/subjects" class="nav-link">Subjects</a>
            <a href="${pageContext.request.contextPath}/student/payment" class="nav-link active">Payment</a>
        </nav>

        <div class="user-controls">
            <a href="${pageContext.request.contextPath}/student/profile" class="profile-icon">
                <i class="fa-solid fa-user"></i>
            </a>

            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
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

        <form action="${pageContext.request.contextPath}/student/payment" method="post">

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

</body>
</html>
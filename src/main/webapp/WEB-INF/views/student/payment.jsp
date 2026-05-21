<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-common.css">
</head>
<body>

<c:set var="activePage" value="payment" scope="request" />
<jsp:include page="/WEB-INF/views/student/studentNavbar.jsp" />


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
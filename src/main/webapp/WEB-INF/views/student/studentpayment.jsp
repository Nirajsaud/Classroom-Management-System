<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Pathshala</title>
    <link rel="stylesheet" href="studentpayment.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <div class="navbar-brand">
        <span class="brand-text">path<span class="brand-accent">shala</span></span>
    </div>
    <ul class="navbar-links">
        <li><a href="dashboard.jsp"><i class="fas fa-th-large"></i> Dashboard</a></li>
        <li><a href="classrooms.jsp"><i class="fas fa-edit"></i> Classrooms</a></li>
        <li><a href="subjects.jsp"><i class="fas fa-book"></i> Subjects</a></li>
        <li><a href="studentpayment.jsp" class="active"><i class="fas fa-wallet"></i> Payment</a></li>
    </ul>
    <div class="navbar-actions">
        <a href="#" class="icon-btn"><i class="fas fa-bell"></i></a>
        <span class="divider">|</span>
        <a href="#" class="icon-btn"><i class="fas fa-user-circle"></i></a>
        <a href="logout.jsp" class="logout-btn">Logout</a>
    </div>
</nav>

<!-- Main Content -->
<div class="main-container">
    <div class="payment-card">
        <div class="payment-header">
            <h2>Payment</h2>
            <hr class="header-divider">
        </div>

        <div class="payment-body">
            <%-- Replace grades array with actual model attribute, e.g.: --%>
            <%-- <c:forEach var="grade" items="${enrolledGrades}"> --%>

            <%
                // Simulated data — replace with actual request attribute
                String[] grades = {"Grade 5"};
                // String[] grades = (String[]) request.getAttribute("enrolledGrades");
            %>

            <% if (grades != null && grades.length > 0) {
                for (String grade : grades) { %>
            <div class="payment-row">
                <span class="grade-label"><%= grade %></span>
                <button class="btn-complete-payment" onclick="handlePayment('<%= grade %>')">
                    Complete Payment
                </button>
            </div>
            <% } } else { %>
            <div class="no-payment">
                <p>No pending payments found.</p>
            </div>
            <% } %>
        </div>
    </div>
</div>

<script>
    function handlePayment(grade) {
        // Replace with actual payment logic or redirect
        // window.location.href = 'processpayment.jsp?grade=' + encodeURIComponent(grade);
        alert('Redirecting to payment gateway for: ' + grade);
    }
</script>

</body>
</html>

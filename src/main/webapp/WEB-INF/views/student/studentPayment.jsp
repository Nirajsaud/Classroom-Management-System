<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Student Payment</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentPayment.css">
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

                <a href="${pageContext.request.contextPath}/student/classroom" class="nav-link">
                    <i class="fa-solid fa-pen-nib"></i> Classrooms
                </a>

                <a href="${pageContext.request.contextPath}/student/subjects" class="nav-link">
                    <i class="fa-solid fa-book"></i> Subjects
                </a>

                <a href="${pageContext.request.contextPath}/student/payment" class="nav-link active">
                    <i class="fa-solid fa-wallet"></i> Payment
                </a>
            </nav>

            <div class="user-controls">
                <i class="fa-regular fa-bell bell-icon"></i>

                <div class="v-divider"></div>

                <a href="${pageContext.request.contextPath}/student/profile" class="profile-icon">
                    <i class="fa-solid fa-user"></i>
                </a>

                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </header>

    <main class="payment-page">
        <section class="payment-header">
            <h1>My Payments</h1>
            <p>Track your purchased classroom packages and payment details.</p>
        </section>

        <section class="summary-grid">
            <div class="summary-card">
                <i class="fa-solid fa-wallet"></i>
                <div>
                    <h3>Total Paid</h3>
                    <p>Rs. 7,000</p>
                </div>
            </div>

            <div class="summary-card">
                <i class="fa-solid fa-book-open-reader"></i>
                <div>
                    <h3>Active Packages</h3>
                    <p>2 Classes</p>
                </div>
            </div>

            <div class="summary-card">
                <i class="fa-solid fa-circle-check"></i>
                <div>
                    <h3>Status</h3>
                    <p>Active</p>
                </div>
            </div>
        </section>

        <section class="payment-table-card">
            <div class="table-title">
                <h2>Payment History</h2>
                <span>Recent transactions</span>
            </div>

            <div class="payment-table">
                <div class="table-row table-head">
                    <span>Classroom</span>
                    <span>Amount</span>
                    <span>Payment Method</span>
                    <span>Payment Date</span>
                    <span>Status</span>
                </div>

                <div class="table-row">
                    <span>Grade 4</span>
                    <span>Rs. 3,500</span>
                    <span>Card Payment</span>
                    <span>2026-01-23</span>
                    <span class="status paid">Paid</span>
                </div>

                <div class="table-row">
                    <span>Grade 5</span>
                    <span>Rs. 3,500</span>
                    <span>Card Payment</span>
                    <span>2026-02-10</span>
                    <span class="status paid">Paid</span>
                </div>

                <div class="table-row">
                    <span>Grade 6</span>
                    <span>Rs. 4,000</span>
                    <span>Pending</span>
                    <span>-</span>
                    <span class="status pending">Pending</span>
                </div>
            </div>
        </section>
    </main>

</body>
</html>
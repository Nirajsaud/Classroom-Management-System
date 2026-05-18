<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Student Classrooms</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentClassroom.css">
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

                <a href="${pageContext.request.contextPath}/student/classroom" class="nav-link active">
                    <i class="fa-solid fa-pen-nib"></i> Classrooms
                </a>

                <a href="${pageContext.request.contextPath}/student/subjects" class="nav-link">
                    <i class="fa-solid fa-book"></i> Subjects
                </a>

                <a href="${pageContext.request.contextPath}/student/payment" class="nav-link">
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

    <main class="classroom-page">

        <section class="filter-bar">
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="Search Classroom">
                <i class="fa-solid fa-magnifying-glass search-icon"></i>
            </div>

            <button type="button" id="searchBtn" class="search-btn">Search</button>

            <select id="priceFilter" class="filter-select">
                <option value="default">Default</option>
                <option value="low">Lowest Price First</option>
                <option value="high">Highest Price First</option>
            </select>
        </section>

        <section class="classroom-grid" id="classroomGrid">

            <div class="classroom-card" data-title="grade 4" data-price="3500">
                <div class="book-icon">
                    <i class="fa-solid fa-book-open"></i>
                </div>

                <div class="card-divider"></div>

                <div class="classroom-info">
                    <h2>Grade 4</h2>
                    <p>Full Grade 4 syllabus</p>
                    <h3>Price: Rs.3500</h3>

                    <button type="button" class="buy-btn" onclick="openPaymentModal()">
                        <i class="fa-regular fa-square-plus"></i>
                        Buy Package
                    </button>
                </div>
            </div>

            <div class="classroom-card" data-title="grade 5" data-price="3500">
                <div class="book-icon">
                    <i class="fa-solid fa-book-open"></i>
                </div>

                <div class="card-divider"></div>

                <div class="classroom-info">
                    <h2>Grade 5</h2>
                    <p>Full Grade 5 syllabus</p>
                    <h3>Price: Rs.3500</h3>

                    <button type="button" class="buy-btn" onclick="openPaymentModal()">
                        <i class="fa-regular fa-square-plus"></i>
                        Buy Package
                    </button>
                </div>
            </div>

            <div class="classroom-card" data-title="grade 6" data-price="4000">
                <div class="book-icon">
                    <i class="fa-solid fa-book-open"></i>
                </div>

                <div class="card-divider"></div>

                <div class="classroom-info">
                    <h2>Grade 6</h2>
                    <p>Full Grade 6 syllabus</p>
                    <h3>Price: Rs.4000</h3>

                    <button type="button" class="buy-btn" onclick="openPaymentModal()">
                        <i class="fa-regular fa-square-plus"></i>
                        Buy Package
                    </button>
                </div>
            </div>

            <div class="classroom-card" data-title="grade 7" data-price="4000">
                <div class="book-icon">
                    <i class="fa-solid fa-book-open"></i>
                </div>

                <div class="card-divider"></div>

                <div class="classroom-info">
                    <h2>Grade 7</h2>
                    <p>Full Grade 7 syllabus</p>
                    <h3>Price: Rs.4000</h3>

                    <button type="button" class="buy-btn" onclick="openPaymentModal()">
                        <i class="fa-regular fa-square-plus"></i>
                        Buy Package
                    </button>
                </div>
            </div>

            <div class="classroom-card" data-title="grade 8" data-price="4500">
                <div class="book-icon">
                    <i class="fa-solid fa-book-open"></i>
                </div>

                <div class="card-divider"></div>

                <div class="classroom-info">
                    <h2>Grade 8</h2>
                    <p>Full Grade 8 syllabus</p>
                    <h3>Price: Rs.4500</h3>

                    <button type="button" class="buy-btn" onclick="openPaymentModal()">
                        <i class="fa-regular fa-square-plus"></i>
                        Buy Package
                    </button>
                </div>
            </div>

            <div class="classroom-card" data-title="grade 9" data-price="4500">
                <div class="book-icon">
                    <i class="fa-solid fa-book-open"></i>
                </div>

                <div class="card-divider"></div>

                <div class="classroom-info">
                    <h2>Grade 9</h2>
                    <p>Full Grade 9 syllabus</p>
                    <h3>Price: Rs.4500</h3>

                    <button type="button" class="buy-btn" onclick="openPaymentModal()">
                        <i class="fa-regular fa-square-plus"></i>
                        Buy Package
                    </button>
                </div>
            </div>

            <div class="classroom-card" data-title="grade 10" data-price="5000">
                <div class="book-icon">
                    <i class="fa-solid fa-book-open"></i>
                </div>

                <div class="card-divider"></div>

                <div class="classroom-info">
                    <h2>Grade 10</h2>
                    <p>Full Grade 10 syllabus</p>
                    <h3>Price: Rs.5000</h3>

                    <button type="button" class="buy-btn" onclick="openPaymentModal()">
                        <i class="fa-regular fa-square-plus"></i>
                        Buy Package
                    </button>
                </div>
            </div>

        </section>

        <p id="emptyMessage" class="empty-message">No classroom matched your search.</p>
    </main>
    <div class="payment-overlay" id="paymentOverlay">
    <div class="payment-modal">

        <button type="button" class="payment-cancel-btn" onclick="closePaymentModal()">
            Cancel
        </button>

        <form action="${pageContext.request.contextPath}/student/payment" method="post" class="payment-form">

            <div class="payment-group">
                <div>
                    <label for="cardNumber">Card Number</label>
                    <p>Enter the 16-digit number on the card</p>
                </div>
                <input type="text" id="cardNumber" name="cardNumber" placeholder="0 0 0 0  -  0 0 0 0  -  0 0 0 0  -  0 0 0 0">
            </div>

            <div class="payment-group payment-two-column">
                <div>
                    <label for="cvv">CVV Number</label>
                    <p>Enter the 3 or 4 digit number on the card</p>
                </div>
                <input type="text" id="cvv" name="cvv">
            </div>

            <div class="payment-group payment-two-column">
                <div>
                    <label>Expiry Data</label>
                    <p>Enter the expiration date of the card</p>
                </div>

                <div class="expiry-inputs">
                    <input type="text" name="expiryMonth">
                    <input type="text" name="expiryYear">
                </div>
            </div>

            <div class="payment-group payment-two-column">
                <div>
                    <label for="password">Password</label>
                    <p>Enter your Dynamic password</p>
                </div>
                <input type="password" id="password" name="password">
            </div>

            <button type="submit" class="pay-now-btn">Pay Now</button>
        </form>
    </div>
</div>

    <script src="${pageContext.request.contextPath}/js/studentClassroom.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Contact Support</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacherContact.css">
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

                <a href="${pageContext.request.contextPath}/teacher/classroom" class="nav-link">
                    <i class="fa-solid fa-pen-nib"></i> Classrooms
                </a>

                <a href="${pageContext.request.contextPath}/teacher/subjects" class="nav-link">
                    <i class="fa-regular fa-bookmark"></i> Subjects
                </a>

                <a href="${pageContext.request.contextPath}/teacher/payment" class="nav-link">
                    <i class="fa-regular fa-credit-card"></i> Payment
                </a>
            </nav>

            <div class="user-controls">
                <a href="${pageContext.request.contextPath}/teacher/contact" class="bell-link">
                    <i class="fa-regular fa-bell bell-icon"></i>
                </a>

                <div class="v-divider"></div>

                <a href="${pageContext.request.contextPath}/teacher/profile" class="profile-icon">
                    <i class="fa-solid fa-user"></i>
                </a>

                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </header>

    <main class="contact-page">
        <section class="contact-left">
            <h1>Get in Touch</h1>
            <p>
                Have questions? We'd love to hear from you. Send us a message
                and we'll respond as soon as possible.
            </p>

            <form action="${pageContext.request.contextPath}/teacher/contact" method="post" class="contact-form">
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">NAME</label>
                        <input type="text" id="name" name="name">
                    </div>

                    <div class="form-group">
                        <label for="email">EMAIL</label>
                        <input type="email" id="email" name="email">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">PHONE</label>
                        <input type="text" id="phone" name="phone">
                    </div>

                    <div class="form-group">
                        <label for="subject">SUBJECT</label>
                        <input type="text" id="subject" name="subject">
                    </div>
                </div>

                <div class="form-group full-width">
                    <label for="message">MESSAGE</label>
                    <textarea id="message" name="message"></textarea>
                </div>

                <button type="submit" class="send-btn">SEND</button>
            </form>
        </section>

        <section class="contact-card">
            <h2>Contact Information</h2>

            <div class="info-list">
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fa-regular fa-envelope"></i>
                    </div>
                    <div>
                        <h3>EMAIL</h3>
                        <p>info.Pathshala@gmail.com</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fa-solid fa-phone"></i>
                    </div>
                    <div>
                        <h3>PHONE</h3>
                        <p>+977 9767965747</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fa-solid fa-location-dot"></i>
                    </div>
                    <div>
                        <h3>ADDRESS</h3>
                        <span>Kalanki, Kathmandu, Nepal</span>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fa-regular fa-clock"></i>
                    </div>
                    <div>
                        <h3>WORKING HOURS</h3>
                        <span>Monday - Friday</span>
                        <span>09:00 - 18:00</span>
                    </div>
                </div>
            </div>

            <div class="social-row">
                <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
                <a href="#"><i class="fa-brands fa-facebook"></i></a>
            </div>
        </section>
    </main>

</body>
</html>
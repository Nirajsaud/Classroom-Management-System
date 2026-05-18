<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Student Profile</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentProfile.css">
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

                <a href="${pageContext.request.contextPath}/student/classrooms" class="nav-link">
                    <i class="fa-solid fa-pen-nib"></i> Classrooms
                </a>

                <a href="${pageContext.request.contextPath}/student/subjects" class="nav-link">
                    <i class="fa-regular fa-bookmark"></i> Subjects
                </a>

                <a href="${pageContext.request.contextPath}/student/payment" class="nav-link">
                    <i class="fa-regular fa-credit-card"></i> Payment
                </a>
            </nav>

            <div class="user-controls">
                <i class="fa-regular fa-bell bell-icon"></i>

                <div class="v-divider"></div>

                <a href="${pageContext.request.contextPath}/student/profile" class="profile-icon active-profile">
                    <i class="fa-solid fa-user"></i>
                </a>

                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </header>

    <main class="profile-page">
        <h1 class="page-title">Student Profile</h1>

        <form action="${pageContext.request.contextPath}/student/profile" method="post" class="profile-form">
            <section class="profile-top">
                <div class="photo-box">
                    <i class="fa-solid fa-user"></i>
                </div>

                <div class="personal-details">
                    <div class="section-title">
                        <i class="fa-solid fa-user"></i>
                        <h2>Personal Details</h2>
                    </div>

                    <div class="form-group">
                        <label for="fullName">FULL NAME</label>
                        <input type="text" id="fullName" name="fullName" placeholder="Full name" value="Student Name">
                    </div>

                    <div class="form-group">
                        <label for="phoneNumber">PHONE NUMBER</label>
                        <input type="text" id="phoneNumber" name="phoneNumber" placeholder="Phone number" value="9800000000">
                    </div>

                    <div class="form-group">
                        <label for="email">EMAIL</label>
                        <input type="email" id="email" name="email" placeholder="Email" value="student@pathshala.com">
                    </div>
                </div>
            </section>

            <section class="security-section">
                <div class="section-title">
                    <i class="fa-solid fa-lock"></i>
                    <h2>Security</h2>
                </div>

                <div class="security-grid">
                    <div class="form-group password-field">
                        <label for="currentPassword">Password</label>
                        <input type="password" id="currentPassword" name="currentPassword">
                    </div>

                    <div class="security-row">
                        <div class="form-group">
                            <label for="newPassword">Change Password</label>
                            <input type="password" id="newPassword" name="newPassword">
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword">
                        </div>
                    </div>
                </div>
            </section>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/dashboard" class="cancel-btn">Cancel Changes</a>
                <button type="submit" class="save-btn">Save Changes</button>
            </div>
        </form>
    </main>

</body>
</html>
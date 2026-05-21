<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala - Sign Up</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        /* Tutor's Error Alert Styling */
        .error-container {
            background: #fff1f2;
            border: 1px solid #fecdd3;
            color: #e11d48;
            padding: 0.75rem 1rem;
            border-radius: 10px;
            font-size: 0.85rem;
            margin-bottom: 1.25rem;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: fadeIn 0.3s ease forwards;
            transition: opacity 0.5s ease, transform 0.5s ease, margin 0.5s ease;
            overflow: hidden;
        }

        .fade-out {
            opacity: 0;
            transform: translateY(-10px);
            margin-bottom: 0;
            padding-top: 0;
            padding-bottom: 0;
            height: 0;
            border: 0;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-5px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="signup-container">
        
        <div class="hero-section">
            <div class="hero-content">
                <h1 class="logo-text">pathshala</h1>
                <div class="underline"></div>
                <h2 class="hero-tagline">Empowering the Next Generation of pupil.</h2>
            </div>
        </div>

        <div class="form-section">
            <div class="form-wrapper">
                <div class="form-header">
                    <h2>Welcome,</h2>
                    <p>Please enter your details to continue</p>
                </div>

                <c:if test="${not empty error}">
                    <div id="errorPopup" class="error-container">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <span>${error}</span>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/signup" method="post" novalidate>
                    <div class="input-group">
                        <label>Name</label>
                        <input type="text" name="fullName" placeholder="Kritika Basel" value="${param.fullName}">
                    </div>

                    <div class="input-group">
                        <label>Phone Number</label>
                        <input type="text" name="phone" placeholder="1234567890" value="${param.phone}">
                    </div>

                    <div class="input-group">
                        <label>EMAIL ADDRESS</label>
                        <div class="field-wrapper">
                            <i class="fa-regular fa-envelope icon-left"></i>
                            <input type="text" name="email" placeholder="krikita.basel@gmail.com" value="${param.email}">
                        </div>
                    </div>

                    <div class="input-group">
                        <label>PASSWORD</label>
                        <div class="field-wrapper">
                            <i class="fa-solid fa-lock icon-left"></i>
                            <input type="password" id="password" name="password" placeholder="••••••••••">
                        </div>
                    </div>

                    <button type="submit" class="signup-btn">
                        Sign Up <i class="fa-solid fa-arrow-right"></i>
                    </button>
                </form>

                <div class="form-footer">
                    <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Log In</a></p>
                    <p>Trouble Signing Up? <a href="${pageContext.request.contextPath}/contact">Contact Administrator</a></p>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const errorPopup = document.getElementById('errorPopup');
            if (errorPopup) {
                setTimeout(() => {
                    errorPopup.classList.add('fade-out');
                    setTimeout(() => {
                        errorPopup.remove();
                    }, 500);
                }, 5000);
            }
        });
    </script>
    <script src="${pageContext.request.contextPath}/js/signup.js"></script>
</body>
</html>
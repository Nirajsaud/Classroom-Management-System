<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
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
    <div class="page-wrapper">
        <div class="logo-container">
            <h1 class="logo-text">pathshala</h1>
        </div>

        <div class="login-card">
            <div class="card-header">
                <h2>Welcome Back</h2>
                <p>Please enter your details to continue</p>
            </div>

            <c:if test="${not empty error}">
                <div id="errorPopup" class="error-container">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
                <div class="input-group">
                    <label for="email">EMAIL ADDRESS</label>
                    <div class="input-wrapper">
                        <i class="fa-regular fa-envelope icon-left"></i>
                        <input type="text" id="email" name="email" placeholder="krikita.basel@gmail.com" value="${typedUser}">
                    </div>
                </div>

                <div class="input-group">
                    <div class="label-row">
                        <label for="password">PASSWORD</label>
                        <a href="#" class="forgot-link">Forgot Password?</a>
                    </div>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-lock icon-left"></i>
                        <input type="password" id="password" name="password" placeholder="••••••••••">
                    </div>
                </div>

                <button type="submit" class="login-btn">
                    Log In <i class="fa-solid fa-arrow-right"></i>
                </button>
            </form>

            <div class="card-footer">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/signup" class="contact-link">Sign Up</a></p>
                <p>Trouble logging in? <a href="${pageContext.request.contextPath}/contact" class="contact-link">Contact Administrator</a></p>
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
    <script src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
</html>
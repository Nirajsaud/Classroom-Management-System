<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
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

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="input-group">
                    <label for="email">EMAIL ADDRESS</label>
                    <div class="input-wrapper">
                        <i class="fa-regular fa-envelope icon-left"></i>
                        <input type="email" id="email" name="email" placeholder="krikita.basel@gmail.com" required>
                    </div>
                </div>

                <div class="input-group">
                    <div class="label-row">
                        <label for="password">PASSWORD</label>
                        <a href="#" class="forgot-link">Forgot Password?</a>
                    </div>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-lock icon-left"></i>
                        <!-- Pure password input, no eye icon in the HTML anymore -->
                        <input type="password" id="password" name="password" placeholder="••••••••••" required>
                    </div>
                </div>

                <button type="submit" class="login-btn">
                    Log In <i class="fa-solid fa-arrow-right"></i>
                </button>
            </form>

            <div class="card-footer">
                <p>Trouble logging in? <a href="${pageContext.request.contextPath}/contact" class="contact-link">Contact Administrator</a></p>
            </div>
        </div>
    </div>

    <!-- We need this tiny script to handle the "show on click" logic -->
    <script src="../js/login.js"></script>
</body>
</html>
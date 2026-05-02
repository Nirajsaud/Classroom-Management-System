<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala - Sign Up</title>
    <link rel="stylesheet" href="css/signup.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="signup-container">
        
        <!-- Left Hero Section -->
        <div class="hero-section">
            <div class="hero-content">
                <h1 class="logo-text">pathshala</h1>
                <div class="underline"></div>
                <h2 class="hero-tagline">Empowering the Next Generation of pupil.</h2>
            </div>
        </div>

        <!-- Right Form Section -->
        <div class="form-section">
            <div class="form-wrapper">
                <div class="form-header">
                    <h2>Welcome,</h2>
                    <p>Please enter your details to continue</p>
                </div>

                <form action="signup_action.jsp" method="POST">
                    <!-- Name Input -->
                    <div class="input-group">
                        <label>Name</label>
                        <input type="text" name="fullName" placeholder="Kritika Basel" required>
                    </div>

                    <!-- Phone Input -->
                    <div class="input-group">
                        <label>Phone Number</label>
                        <input type="tel" name="phone" placeholder="1234567890" required>
                    </div>

                    <!-- Email Input -->
                    <div class="input-group">
                        <label>EMAIL ADDRESS</label>
                        <div class="field-wrapper">
                            <i class="fa-regular fa-envelope icon-left"></i>
                            <input type="email" name="email" placeholder="krikita.basel@gmail.com" required>
                        </div>
                    </div>

                    <!-- Password Input -->
                    <div class="input-group">
                        <label>PASSWORD</label>
                        <div class="field-wrapper">
                            <i class="fa-solid fa-lock icon-left"></i>
                            <input type="password" id="password" name="password" placeholder="••••••••••" required>
                        </div>
                    </div>

                    <button type="submit" class="signup-btn">
                        Sign Up <i class="fa-solid fa-arrow-right"></i>
                    </button>
                </form>

                <div class="form-footer">
                    <p>Trouble Signing Up? <a href="#">Contact Administratior</a></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Logic to show password on focus -->
    <script src="js/signup.js"></script>
</body>
</html>
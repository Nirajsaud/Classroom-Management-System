<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | About Us</title>
    
    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css">
</head>
<body>

    <!-- Landing page Navbar -->
    <nav class="navbar">
        <div class="nav-left">
            <span class="logo">pathshala</span>
        </div>
        <div class="nav-center">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/about" class="active">About Us</a>
            <a href="${pageContext.request.contextPath}/contact">Contact Us</a>
        </div>
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/login" class="login-link">Log In</a>
            <a href="${pageContext.request.contextPath}/signup" class="btn btn-outline">Join for Free</a>
        </div>
    </nav>

    <!-- Introductory Copy -->
    <section class="about-intro">
        <div class="container-small">
            <h1 class="main-heading">Learning, your way.</h1>
            <p class="main-text">Pathshala is an online e-learning and classroom management platform built to bridge the gap between traditional school education and the modern digital world connecting students, teachers, and administrators in one seamless space.</p>
        </div>
    </section>

    <!-- Platform Description -->
    <section class="about-platform">
        <div class="container-small">
            <h2 class="section-title">What is Pathshala?</h2>
            <p class="platform-text">Pathshala is a student management and e-learning system designed for schools. It supports both students who attend school physically and learners outside the school who want access to quality study resources. Teachers can upload materials, create assignments, and communicate with students all from one platform. Administrators have full control over classrooms, subjects, staff, and semesters.</p>
        </div>
    </section>

    <!-- Team Section -->
    <section class="meet-team">
        <div class="container">
            <h2 class="meet-title">Meet Our Team</h2>
            
            <div class="team-grid">
                <!-- Card 1: Kritika -->
                <div class="team-card card-img-left">
                    <div class="team-img placeholder-red">
                        <!-- Replace placeholder color with <img src="images/kritika.jpg" alt="Kritika Basel"> later -->
                    </div>
                    <div class="team-text">
                        <h3>Kritika Basel</h3>
                        <span class="role">Backend Developer & Database Engineer</span>
                        <p>Kritika builds the engine that powers Pathshala. She designs and manages the database architecture and server-side logic from user role management to semester access control ensuring the platform runs with reliability and precision at its core.</p>
                    </div>
                </div>

                <!-- Card 2: Sabin -->
                <div class="team-card card-img-right">
                    <div class="team-img placeholder-red"></div>
                    <div class="team-text">
                        <h3>Sabin Paudel</h3>
                        <span class="role">Frontend Developer & Quality Assurance Lead</span>
                        <p>Sabin brings Pathshala to life on the screen while making sure every detail holds up under scrutiny. He develops the client-side interface and owns the quality assurance process validating user flows, catching edge cases, and ensuring a consistent, dependable experience.</p>
                    </div>
                </div>

                <!-- Card 3: Nischal -->
                <div class="team-card card-img-left">
                    <div class="team-img placeholder-red"></div>
                    <div class="team-text">
                        <h3>Nischal Raj Joshi</h3>
                        <span class="role">Full Stack Developer</span>
                        <p>Nischal works across every layer of the platform. From frontend interfaces to backend logic, he bridges the gap between design and functionality contributing wherever needed to keep Pathshala cohesive, complete, and technically strong.</p>
                    </div>
                </div>

                <!-- Card 4: Niraj -->
                <div class="team-card card-img-right">
                    <div class="team-img placeholder-red"></div>
                    <div class="team-text">
                        <h3>Niraj Saud</h3>
                        <span class="role">UX Designer & Project Lead</span>
                        <p>Niraj leads Pathshala with a user-first mindset. He drives the overall product vision, oversees project direction, and designs the user experience ensuring the platform is not only functional but intuitive and thoughtfully crafted for every type of user.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer from landing page -->
    <footer class="footer">
        <div class="container footer-grid">
            <div class="footer-brand">
                <span class="logo">pathshala</span>
                <div class="social-icons">
                    <a href="#" class="social-link"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" class="social-link"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" class="social-link"><i class="fa-brands fa-twitter"></i></a>
                </div>
            </div>
            <div class="footer-links">
                <h4>Quick Links</h4>
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <a href="${pageContext.request.contextPath}/about">About Us</a>
                <a href="${pageContext.request.contextPath}/contact">Contact Us</a>
            </div>
            <div class="footer-links">
                <h4>Our Offering</h4>
                <a href="#">Grade 4</a>
                <a href="#">Grade 5</a>
                <a href="#">Grade 6</a>
                <a href="#">Grade 7</a>
                <a href="#">Grade 8</a>
                <a href="#">Grade 9</a>
                <a href="#">Grade 10</a>
            </div>
            <div class="footer-links">
                <h4>Let's Connect</h4>
                <p>Email: help.pathshala@gmail.com</p>
                <p>Phone: +977 9841221122</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; pathshala – Nepal 2026</p>
        </div>
    </footer>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Learning, your way.</title>
    
    <!-- Google Fonts: Inter & Nunito Sans -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Nunito+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome for the social icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>

    <!-- 1. Navbar (3-Zone Layout) -->
    <nav class="navbar">
        <div class="nav-left">
            <span class="logo">pathshala</span>
        </div>
        <div class="nav-center">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/about">About Us</a>
            <a href="${pageContext.request.contextPath}/contact">Contact Us</a>
        </div>
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/login" class="login-link">Log In</a>
            <a href="${pageContext.request.contextPath}/signup" class="btn btn-outline">Join for Free</a>
        </div>
    </nav>

    <!-- 2. Hero Section -->
    <header class="hero">
        <div class="hero-container">
            <!-- Top Layer: Text -->
            <div class="hero-text-layer">
                <h1>Learning, your way.</h1>
                <p>Explore different courses and master a skill. We help you learn<br>and join a growing community of 5,000+ students learning around the world.</p>
                <a href="${pageContext.request.contextPath}/signup" class="btn btn-primary">Get Started</a>
            </div>

            <!-- Bottom Layer: Visual Layout -->
            <div class="hero-visual-layer">
                <!-- Left: Illustration -->
                <div class="hero-illustration">
                    <!-- Replace with hero illustration -->
                    <div>
                    <img src="images/landing_page_hero_girl.jpg" alt="Student Studying">
                    </div>
                </div>

                <!-- Right: Stats Grid -->
                <div class="hero-stats">
                    <div class="stat-card">
                        <h3>1,000+</h3>
                        <p>Active students</p>
                    </div>
                    <div class="stat-card">
                        <h3>42+</h3>
                        <p>Courses available</p>
                    </div>
                    <div class="stat-card">
                        <h3>7</h3>
                        <p>Grade levels covered</p>
                    </div>
                    <div class="stat-card">
                        <h3>60+</h3>
                        <p>Qualified teachers</p>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- 3. Features Section -->
    <section class="features">
        <div class="container features-grid">
            <div class="feature-card">
                <!-- Replace with icon -->
                <div class="placeholder-icon">
                <img src="images/landing_page_flexible_enrollment.jpg"width="200" height="100">
                </div>
                <h4>Flexible Enrollment</h4>
                <p>Study at your own pace with our flexible learning options tailored for you.</p>
            </div>
            <div class="feature-divider"></div>
            <div class="feature-card">
                <!-- Replace with icon -->
                <div class="placeholder-icon">
                <img src="images/landing_page_teacher_led.jpg"width="200" height="100">
                </div>
                <h4>Teacher-Led Learning</h4>
                <p>Personalized support from industry experts to help you navigate your career.</p>
            </div>
            <div class="feature-divider"></div>
            <div class="feature-card">
                <!-- Replace with icon -->
                <div class="placeholder-icon">
                <img src="images/landing_page_organized_dashboard.jpg"width="200" height="100">
                </div>
                <h4>Organized Dashboard</h4>
                <p>An easy-to-use dashboard to track your progress and manage your courses.</p>
            </div>
        </div>
    </section>

    <!-- 4. Subjects Section -->
    <section class="subjects">
        <div class="container">
            <div class="subjects-header">
                <span class="subtitle">SUBJECTS WE COVER</span>
                <h2>Everything on the curriculum</h2>
                <p>All the subjects covered in Pathshala are listed below. Click on any subject to learn more.</p>
            </div>
            <div class="subjects-grid">
                <div class="subject-card">
                    <h3>Mathematics</h3>
                    <p>Arithmetic to Advanced Geometry</p>
                </div>
                <div class="subject-card">
                    <h3>Science</h3>
                    <p>Physics, Chemistry & Biology</p>
                </div>
                <div class="subject-card">
                    <h3>Social Studies</h3>
                    <p>History, Geography & Civics</p>
                </div>
                <div class="subject-card">
                    <h3>English</h3>
                    <p>Reading, Writing & Grammar</p>
                </div>
                <div class="subject-card">
                    <h3>Nepali</h3>
                    <p>Language & Literature</p>
                </div>
                <div class="subject-card">
                    <h3>Computer Science</h3>
                    <p>Digital Literacy & Coding</p>
                </div>
            </div>
        </div>
    </section>

    <!-- 5. CTA Section -->
    <section class="cta">
        <div class="container cta-content">
            <!-- Replace with book image -->
            <div class="placeholder-box img-book">
            <img src="images/landing_page_book.jpg"width="350" height="180">
            </div>
            <h2>Unleash your potential</h2>
            <p>Join thousands of students across Nepal today.</p>
            <a href="${pageContext.request.contextPath}/signup" class="btn btn-primary">Let's Begin</a>
        </div>
    </section>

    <!-- 6. Philosophy Section -->
    <section class="philosophy">
	    <div class="container">
	        <div class="philosophy-header">
	            <h2>Our Core Philosophy</h2>
	            <div class="underline"></div>
	        </div>
	        <div class="philosophy-grid">
	            <!-- Card 1: Integrity -->
	            <div class="philosophy-card">
	                <div class="icon-wrapper">
	                    <i class="fa-solid fa-shield-halved"></i>
	                </div>
	                <h4>Integrity</h4>
	                <p>Upholding the highest moral standards.</p>
	            </div>
	
	            <!-- Card 2: Innovation -->
	            <div class="philosophy-card">
	                <div class="icon-wrapper">
	                    <i class="fa-solid fa-lightbulb"></i>
	                </div>
	                <h4>Innovation</h4>
	                <p>Always pushing boundaries in education.</p>
	            </div>
	
	            <!-- Card 3: Inclusivity -->
	            <div class="philosophy-card">
	                <div class="icon-wrapper">
	                    <i class="fa-solid fa-hand-holding-heart"></i>
	                </div>
	                <h4>Inclusivity</h4>
	                <p>Learning for every student, everywhere.</p>
	            </div>
	
	            <!-- Card 4: Excellence -->
	            <div class="philosophy-card">
	                <div class="icon-wrapper">
	                    <i class="fa-solid fa-award"></i>
	                </div>
	                <h4>Excellence</h4>
	                <p>Striving for the best in everything we do.</p>
	            </div>
	        </div>
	        <div class="philosophy-action">
	            <a href="${pageContext.request.contextPath}/about" class="btn btn-primary outline-orange">Learn more About Us</a>
	        </div>
	    </div>
	</section>

    <!-- 7. Contact Banner -->
    <section class="contact-banner-wrapper">
        <div class="container">
            <div class="contact-banner">
                <div class="contact-text">
                    <h2>Have questions? We're here to help.</h2>
                    <p>Reach out to us and our team will get back to you as soon as possible.</p>
                    <a href="${pageContext.request.contextPath}/contact" class="btn btn-primary">Contact Us</a>
                </div>
                <div class="contact-visual">
                    <!-- Replace with support illustration -->
                    <div class="placeholder-box img-support">
                    <img src="images/landing_page_contact.jpg"width="300" height="300">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 8. Footer -->
    <footer class="footer">
        <div class="container footer-grid">
            <div class="footer-brand">
                <span class="logo">pathshala</span>
                <div class="social-icons">
                    <!-- Real icons using FontAwesome -->
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
            <p>&copy; pathshala &ndash; Nepal 2026</p>
        </div>
    </footer>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css">
</head>
<body>

    <!-- 1. Navbar (3-Zone Layout) -->
    <nav class="navbar" id="navbar">
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

    <!-- Hero / Intro -->
    <section class="about-hero">
        <div class="hero-bg-shapes">
            <div class="shape shape-1"></div>
            <div class="shape shape-2"></div>
            <div class="shape shape-3"></div>
        </div>
        <div class="container-small hero-content">
            <div class="hero-badge reveal">Our Story</div>
            <h1 class="hero-heading reveal">Learning,<br><em>your way.</em></h1>
            <p class="hero-text reveal">Pathshala is an online e-learning and classroom management platform built to bridge the gap between traditional school education and the modern digital world connecting students, teachers, and administrators in one seamless space.</p>
        </div>
    </section>

    <!-- What is Pathshala -->
    <section class="about-platform">
        <div class="container platform-inner">
            <div class="platform-label reveal">The Platform</div>
            <div class="platform-grid">
                <div class="platform-left reveal">
                    <h2 class="section-title">What is<br>Pathshala?</h2>
                </div>
                <div class="platform-right reveal">
                    <p class="platform-text">Pathshala is a student management and e-learning system designed for schools. It supports both students who attend school physically and learners outside the school who want access to quality study resources.</p>
                    <p class="platform-text">Teachers can upload materials, create assignments, and communicate with students all from one platform. Administrators have full control over classrooms, subjects, staff, and semesters.</p>
                    <div class="feature-pills">
                        <span class="pill"><i class="fa-solid fa-graduation-cap"></i> Student Portal</span>
                        <span class="pill"><i class="fa-solid fa-chalkboard-teacher"></i> Teacher Tools</span>
                        <span class="pill"><i class="fa-solid fa-shield-halved"></i> Admin Control</span>
                        <span class="pill"><i class="fa-solid fa-book-open"></i> E-Learning</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Divider Wave -->
    <div class="wave-divider">
        <svg viewBox="0 0 1440 80" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M0,40 C360,80 1080,0 1440,40 L1440,80 L0,80 Z" fill="#1E3A8A"/>
        </svg>
    </div>

    <!-- Team Section -->
    <section class="meet-team">
        <div class="team-bg-pattern"></div>
        <div class="container">
            <div class="team-header">
                <div class="team-eyebrow reveal">The People Behind It</div>
                <h2 class="meet-title reveal">Meet Our Team</h2>
                <p class="team-subtitle reveal">Four builders with one goal making education more accessible.</p>
            </div>

            <div class="team-grid">

                <!-- Card 1: Kritika -->
                <div class="team-card reveal" data-delay="0">
                    <div class="team-card-inner">
                        <div class="team-img-wrap">
                            <img
                                src="images/kritika.jpeg"
                                alt="Kritika Basel"
                                class="team-img team-photo"
                                onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                            >
                            <div class="team-img placeholder-warm" style="display:none;">
                                <div class="img-placeholder-content">
                                    <div class="placeholder-avatar"><i class="fa-solid fa-user"></i></div>
                                    <span class="placeholder-name">Kritika Basel</span>
                                    <span class="placeholder-label">Photo coming soon</span>
                                </div>
                            </div>
                            <div class="card-number">01</div>
                        </div>
                        <div class="team-text">
                            <span class="role"><i class="fa-solid fa-server"></i> Backend Developer & Database Engineer</span>
                            <h3>Kritika Basel</h3>
                            <p>Kritika builds the engine that powers Pathshala. She designs and manages the database architecture and server-side logic from user role management to semester access control — ensuring the platform runs with reliability and precision at its core.</p>
                            <div class="card-tags">
                                <span>Database</span>
                                <span>Server-Side</span>
                                <span>Architecture</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Card 2: Sabin -->
                <div class="team-card reveal" data-delay="100">
                    <div class="team-card-inner">
                        <div class="team-img-wrap">
                            <img
                                src="images/sabin.jpeg"
                                alt="Sabin Paudel"
                                class="team-img team-photo"
                                onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                            >
                            <div class="team-img placeholder-warm" style="display:none;">
                                <div class="img-placeholder-content">
                                    <div class="placeholder-avatar"><i class="fa-solid fa-user"></i></div>
                                    <span class="placeholder-name">Sabin Paudel</span>
                                    <span class="placeholder-label">Photo coming soon</span>
                                </div>
                            </div>
                            <div class="card-number">02</div>
                        </div>
                        <div class="team-text">
                            <span class="role"><i class="fa-solid fa-display"></i> Frontend Developer & QA Lead</span>
                            <h3>Sabin Paudel</h3>
                            <p>Sabin brings Pathshala to life on the screen while making sure every detail holds up under scrutiny. He develops the client-side interface and owns quality assurance validating user flows, catching edge cases, and ensuring a consistent experience.</p>
                            <div class="card-tags">
                                <span>Frontend</span>
                                <span>QA</span>
                                <span>UI</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Card 3: Nischal -->
                <div class="team-card reveal" data-delay="200">
                    <div class="team-card-inner">
                        <div class="team-img-wrap">
                            <img
                                src="images/nischal.jpeg"
                                alt="Nischal Raj Joshi"
                                class="team-img team-photo"
                                onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                            >
                            <div class="team-img placeholder-warm" style="display:none;">
                                <div class="img-placeholder-content">
                                    <div class="placeholder-avatar"><i class="fa-solid fa-user"></i></div>
                                    <span class="placeholder-name">Nischal Raj Joshi</span>
                                    <span class="placeholder-label">Photo coming soon</span>
                                </div>
                            </div>
                            <div class="card-number">03</div>
                        </div>
                        <div class="team-text">
                            <span class="role"><i class="fa-solid fa-layer-group"></i> Full Stack Developer</span>
                            <h3>Nischal Raj Joshi</h3>
                            <p>Nischal works across every layer of the platform. From frontend interfaces to backend logic, he bridges the gap between design and functionality contributing wherever needed to keep Pathshala cohesive, complete, and technically strong.</p>
                            <div class="card-tags">
                                <span>Full Stack</span>
                                <span>Integration</span>
                                <span>Dev</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Card 4: Niraj -->
                <div class="team-card reveal" data-delay="300">
                    <div class="team-card-inner">
                        <div class="team-img-wrap">
                            <img
                                src="images/niraj.jpeg"
                                alt="Niraj Saud"
                                class="team-img team-photo"
                                onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                            >
                            <div class="team-img placeholder-warm" style="display:none;">
                                <div class="img-placeholder-content">
                                    <div class="placeholder-avatar"><i class="fa-solid fa-user"></i></div>
                                    <span class="placeholder-name">Niraj Saud</span>
                                    <span class="placeholder-label">Photo coming soon</span>
                                </div>
                            </div>
                            <div class="card-number">04</div>
                        </div>
                        <div class="team-text">
                            <span class="role"><i class="fa-solid fa-compass-drafting"></i> UX Designer & Project Lead</span>
                            <h3>Niraj Saud</h3>
                            <p>Niraj leads Pathshala with a user-first mindset. He drives the overall product vision, oversees project direction, and designs the user experience ensuring the platform is not only functional but intuitive and thoughtfully crafted for every type of user.</p>
                            <div class="card-tags">
                                <span>UX Design</span>
                                <span>Leadership</span>
                                <span>Vision</span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- Bottom Wave -->
    <div class="wave-divider wave-bottom">
        <svg viewBox="0 0 1440 80" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M0,40 C360,0 1080,80 1440,40 L1440,0 L0,0 Z" fill="#1E3A8A"/>
        </svg>
    </div>

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

    <script src="${pageContext.request.contextPath}/js/about.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us | Pathshala</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public-navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public-animations.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css">
    
    <style>
        /* Tutor-Compliant Message Styling */
        .status-container {
            padding: 0.75rem 1rem;
            border-radius: 10px;
            font-size: 0.85rem;
            margin-bottom: 1.25rem;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: fadeIn 0.3s ease forwards;
            transition: opacity 0.5s ease, transform 0.5s ease;
        }
        .status-error {
            background: #fff1f2;
            border: 1px solid #fecdd3;
            color: #e11d48;
        }
        .status-success {
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            color: #16a34a;
        }
        .fade-out {
            opacity: 0;
            transform: translateY(-10px);
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-5px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <!-- 1. Navbar (3-Zone Layout) -->
<nav class="public-navbar" id="publicNavbar">
    <div class="public-nav-left">
        <a href="${pageContext.request.contextPath}/home" class="public-logo">pathshala</a>
    </div>

    <button class="public-mobile-toggle" id="mobileToggle" type="button" aria-label="Toggle navigation" aria-expanded="false">
        <span></span>
        <span></span>
        <span></span>
    </button>

    <div class="public-nav-center">
        <a href="${pageContext.request.contextPath}/home" class="public-nav-link">Home</a>
        <a href="${pageContext.request.contextPath}/about" class="public-nav-link">About Us</a>
        <a href="${pageContext.request.contextPath}/contact" class="public-nav-link active">Contact Us</a>
    </div>

    <div class="public-nav-right">
        <a href="${pageContext.request.contextPath}/login" class="public-login-link">Log In</a>
        <a href="${pageContext.request.contextPath}/signup" class="btn btn-outline">Join for Free</a>
    </div>
</nav>

	<!-- Decorative background elements -->
    <div class="accent-blob top-right"></div>
    <div class="accent-blob bottom-right"></div>
	
	<!-- Contact Section -->
    <main class="contact-section">
        <div class="contact-container">
            <!-- Left: Contact Form -->
            <div class="contact-form-wrapper">
                <div class="form-header">
                    <h1 class="form-title">Get in Touch</h1>
                    <p class="form-subtitle">Have questions? We'd love to hear from you. Send us a message and we'll respond as soon as possible.</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="status-container status-error feedback-popup">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <span>${error}</span>
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="status-container status-success feedback-popup">
                        <i class="fa-solid fa-circle-check"></i>
                        <span>${success}</span>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/contact" method="POST" class="contact-form" id="contactForm" novalidate>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" id="name" name="name" placeholder="Your Full Name" value="${param.name}">
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="text" id="email" name="email" placeholder="your@email.com" value="${param.email}">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="phone">Phone</label>
                            <input type="text" id="phone" name="phone" placeholder="+977 98xxxxxxxx" value="${param.phone}">
                        </div>
                        <div class="form-group">
                            <label for="subject">Subject</label> <select id="subject" name="subject">
								<option value="">Select a subject</option>
								<option value="Technical Support"
									${param.subject == 'Technical Support' ? 'selected' : ''}>Technical
									Support</option>
								<option value="Admission Inquiry"
									${param.subject == 'Admission Inquiry' ? 'selected' : ''}>Admission
									Inquiry</option>
								<option value="Payment & Billing"
									${param.subject == 'Payment & Billing' ? 'selected' : ''}>Payment
									& Billing</option>
								<option value="Feedback"
									${param.subject == 'Feedback' ? 'selected' : ''}>Feedback</option>
								<option value="Partnership"
									${param.subject == 'Partnership' ? 'selected' : ''}>Partnership</option>
							</select>
						</div>
                    </div>

                    <div class="form-group full-width">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" placeholder="Please tell us more about your inquiry..." rows="5">${param.message}</textarea>
                    </div>

                    <button type="submit" class="submit-btn">Send Message</button>
                </form>
            </div>

            <!-- Right: Contact Info -->
            <div class="contact-info-wrapper">
                <div class="info-box">
                    <h3 class="info-box-title">Contact Information</h3>
                    
                    <div class="info-group">
                        <div class="info-item">
                            <div class="icon-circle">
                                <i class="fas fa-envelope"></i>
                            </div>
                            <div class="info-content">
                                <h4>Email</h4>
                                <p><a href="mailto:info.Pathshala@gmail.com">info.Pathshala@gmail.com</a></p>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="icon-circle">
                                <i class="fas fa-phone"></i>
                            </div>
                            <div class="info-content">
                                <h4>Phone</h4>
                                <p><a href="tel:+9779767965747">+977 9767965747</a></p>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="icon-circle">
                                <i class="fas fa-location-dot"></i>
                            </div>
                            <div class="info-content">
                                <h4>Address</h4>
                                <p>Kalanki, Kathmandu, Nepal</p>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="icon-circle">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="info-content">
                                <h4>Working Hours</h4>
                                <p>Monday - Friday<br>09:00 AM - 06:00 PM</p>
                            </div>
                        </div>
                    </div>

                    <!-- Social Links -->
                    <div class="social-connect">
                        <p class="social-title">Follow Us</p>
                        <div class="social-icons-contact">
                            <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                            <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

	
    <!-- Success Message -->
    <div class="success-message" id="successMsg">
        <i class="fas fa-check-circle"></i>
        <p>Thank you! Your message has been sent successfully.</p>
    </div>

    <!-- Footer -->
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
                <h4>Nav Bar</h4>
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
                <p>info.pathshala@gmail.com</p>
                <p>+977 9869357800</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; pathshala &ndash; Nepal 2026</p>
        </div>
    </footer>


    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const lookups = document.querySelectorAll('.feedback-popup');
            lookups.forEach(function(popup) {
                setTimeout(() => {
                    popup.classList.add('fade-out');
                    setTimeout(() => { popup.remove(); }, 500);
                }, 5000);
            });
        });
    </script>
    <script src="${pageContext.request.contextPath}/js/contact.js"></script>
</body>
</html>
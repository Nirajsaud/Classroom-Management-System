<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us | Pathshala</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="../css/contact.css">
</head>
<body>
    <!-- Navbar (3-Zone Layout) -->
    <nav class="navbar">
        <div class="nav-left">
            <span class="logo">pathshala</span>
        </div>
        <div class="nav-center">
            <a href="#">Home</a>
            <a href="#">About Us</a>
            <a href="#">Contact Us</a>
        </div>
        <div class="nav-right">
            <a href="#" class="login-link">Log In</a>
            <a href="#" class="btn btn-outline">Join for Free</a>
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

                <form action="ContactController" method="POST" class="contact-form" id="contactForm">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" id="name" name="name" required placeholder="Your Full Name">
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" required placeholder="your@email.com">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="phone">Phone</label>
                            <input type="tel" id="phone" name="phone" placeholder="+977 98xxxxxxxx">
                        </div>
                        <div class="form-group">
                            <label for="subject">Subject</label>
                            <select id="subject" name="subject" required>
                                <option value="">Select a subject</option>
                                <option value="technical_support">Technical Support</option>
                                <option value="admission">Admission Inquiry</option>
                                <option value="billing">Payment & Billing</option>
                                <option value="feedback">Feedback</option>
                                <option value="partnership">Partnership</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" required placeholder="Please tell us more about your inquiry..." rows="5"></textarea>
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
                <a href="#">Home</a>
                <a href="#">About Us</a>
                <a href="#">Contact Us</a>
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

    <script src="index.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Teacher – Pathshala</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin_Teacher.css">
</head>
<body>
<div class="app-wrapper">

    <aside class="sidebar">
        <div class="sidebar-logo">pathshala</div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="3" width="7" height="7" rx="1"/>
                    <rect x="14" y="3" width="7" height="7" rx="1"/>
                    <rect x="3" y="14" width="7" height="7" rx="1"/>
                    <rect x="14" y="14" width="7" height="7" rx="1"/>
                </svg>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/teachers" class="nav-item active">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M22 10v6M2 10l10-5 10 5-10 5z"/>
                    <path d="M6 12v5c3 3 9 3 12 0v-5"/>
                </svg>
                <span>Teachers</span>
            </a>
            <a href="${pageContext.request.contextPath}/students" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                    <circle cx="9" cy="7" r="4"/>
                    <path d="M23 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/>
                </svg>
                <span>Students</span>
            </a>
            <a href="${pageContext.request.contextPath}/classrooms" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                    <polyline points="9 22 9 12 15 12 15 22"/>
                </svg>
                <span>Classrooms</span>
            </a>
            <a href="${pageContext.request.contextPath}/report" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                    <polyline points="14 2 14 8 20 8"/>
                    <line x1="16" y1="13" x2="8" y2="13"/>
                    <line x1="16" y1="17" x2="8" y2="17"/>
                    <polyline points="10 9 9 9 8 9"/>
                </svg>
                <span>Report</span>
            </a>
            <a href="${pageContext.request.contextPath}/admincontact" class="nav-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M21 8v10a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8"/>
                    <path d="M3 8l9 6 9-6"/>
                    <path d="M12 14v7"/>
                </svg>
                <span>Contact</span>
            </a>
        </nav>
    </aside>

    <div class="main-area">
        <header class="topbar">
            <div class="bell-wrapper">
                <a href="${pageContext.request.contextPath}/approvals"
                    class="bell-btn" title="Pending Approvals"
                    style="display: flex; align-items: center; text-decoration: none; position: relative;">
                    <svg class="bell-icon" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2"
                        style="width: 24px; height: 24px; color: #111827;">
                        <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9" />
                        <path d="M13.73 21a2 2 0 0 1-3.46 0" /></svg> 
                    <c:if test="${pendingCount > 0}">
                        <span class="bell-badge"
                            style="position: absolute; top: -2px; right: -2px; width: 10px; height: 10px; background: #ef4444; border-radius: 50%;"></span>
                    </c:if>
                </a>
            </div>
            <div class="topbar-divider"></div>
            <a href="${pageContext.request.contextPath}/profile" class="user-avatar" title="Profile" style="display: inline-block; width: 40px; height: 40px; overflow: hidden; border-radius: 50%;">
                <img src="${pageContext.request.contextPath}/getimage?name=${user.email}" 
                     alt="Profile"
                     onerror="this.src='https://via.placeholder.com/80';"
                     style="width: 100%; height: 100%; object-fit: cover; display: block; border-radius: 50%;">
            </a>
            <a href="${pageContext.request.contextPath}/logout-user" class="logout-btn" style="text-decoration: none; display: inline-flex; align-items: center; justify-content: center;">Logout</a>
        </header>

        <main class="content-area">
            <div class="form-header">
                <a href="${pageContext.request.contextPath}/teachers" class="btn-cancel">Cancel</a>
                <h1 class="form-title">Add New Teacher</h1>
            </div>

            <c:if test="${param.status eq 'error'}">
                <div style="padding: 1rem; margin-bottom: 1.5rem; background-color: #fee2e2; color: #991b1b; border: 1px solid #fca5a5; border-radius: 8px; font-size: 0.95rem;">
                    Failed to provision account. Please confirm your input data parameters, check that passwords match completely, or check connection limits.
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/addteacher" method="POST" id="addTeacherForm">
                <div class="form-container">
                    <div class="form-section">
                        <div class="section-header">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                                <circle cx="12" cy="7" r="4"/>
                            </svg>
                            <h2>Personal Details</h2>
                        </div>
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input type="text" name="fullName" placeholder="Full name" required="required">
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" placeholder="Email" required="required">
                            </div>
                            <div class="form-group">
                                <label>Subject</label>
                                <select name="subject" required="required">
                                    <option value="">Select Subject</option>
                                    <option value="Nepali">Nepali</option>
                                    <option value="English">English</option>
                                    <option value="Science">Science</option>
                                    <option value="Math">Math</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="tel" name="phone" placeholder="Phone number" required="required">
                            </div>
                        </div>
                        
                        <div class="form-group full-width">
                            <label>Assign Classroom (Click to toggle selections)</label>
                            
                            <input type="hidden" name="assignedClasses" id="hiddenClassesInput" value="">
                            
                            <div class="classroom-buttons" id="gradeButtonGroup">
                                <button type="button" class="classroom-btn" data-grade="4">4</button>
                                <button type="button" class="classroom-btn" data-grade="5">5</button>
                                <button type="button" class="classroom-btn" data-grade="6">6</button>
                                <button type="button" class="classroom-btn" data-grade="7">7</button>
                                <button type="button" class="classroom-btn" data-grade="8">8</button>
                                <button type="button" class="classroom-btn" data-grade="9">9</button>
                                <button type="button" class="classroom-btn" data-grade="10">10</button>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <div class="section-header">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                                <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                            </svg>
                            <h2>Security</h2>
                        </div>
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" name="password" placeholder="Enter secure password" required="required">
                            </div>
                            <div class="form-group">
                                <label>Confirm Password</label>
                                <input type="password" name="confirmPassword" placeholder="Confirm secure password" required="required">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-footer">
                    <button type="submit" class="btn-create">Create Account</button>
                </div>
            </form>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/Admin_Teacher_Add.js"></script>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        const buttons = document.querySelectorAll('#gradeButtonGroup .classroom-btn');
        const hiddenInput = document.getElementById('hiddenClassesInput');
        let selectedGrades = [];

        buttons.forEach(function(btn) {
            btn.addEventListener('click', function() {
                const grade = this.getAttribute('data-grade');
                
                if (this.classList.contains('active')) {
                    this.classList.remove('active');
                    this.style.backgroundColor = '';
                    this.style.color = '';
                    selectedGrades = selectedGrades.filter(function(g) { return g !== grade; });
                } else {
                    this.classList.add('active');
                    this.style.backgroundColor = '#4f46e5'; // Highlight Indigo matching theme layouts
                    this.style.color = '#ffffff';
                    selectedGrades.push(grade);
                }
                
                // Keep the hidden input updated with a clean sequence string
                hiddenInput.value = selectedGrades.join(',');
            });
        });
    });
</script>
</body>
</html>
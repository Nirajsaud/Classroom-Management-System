<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Teacher – Pathshala</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin_Teacher.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>
<div class="app-wrapper">
    <% request.setAttribute("activePage", "teachers"); %>
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/adminTopbar.jsp" />

        <main class="content-area admin-teacher-page">
            <div class="form-header">
                <a href="${pageContext.request.contextPath}/teachers" class="btn-cancel">Cancel</a>
                <h1 class="form-title">Add New Teacher</h1>
            </div>

            <c:if test="${param.status eq 'error'}">
                <div class="page-alert error-alert">
                    Failed to provision account. Please confirm your input data parameters, check that passwords match completely, or check connection limits.
                </div>
            </c:if>

				<c:if test="${not empty param.status && param.status ne 'error'}">
					<div class="page-alert validation-alert">

						<c:choose>

							<c:when test="${param.status eq 'missing'}">
                All required fields must be filled.
            </c:when>

							<c:when test="${param.status eq 'invalid_name'}">
                Full name must contain only letters and spaces.
            </c:when>

							<c:when test="${param.status eq 'invalid_email'}">
                Please enter a valid email address.
            </c:when>

							<c:when test="${param.status eq 'invalid_phone'}">
                Phone number must contain exactly 10 digits.
            </c:when>

							<c:when test="${param.status eq 'weak_password'}">
                Password must be at least 6 characters long.
            </c:when>

							<c:when test="${param.status eq 'password_mismatch'}">
                Password and confirm password do not match.
            </c:when>

							<c:when test="${param.status eq 'invalid_subject'}">
                Invalid subject selected.
            </c:when>

							<c:when test="${param.status eq 'invalid_class'}">
                Invalid classroom assignment selected.
            </c:when>

							<c:when test="${param.status eq 'invalid_id'}">
                Invalid teacher ID detected.
            </c:when>

						</c:choose>

					</div>
				</c:if>

				<form action="${pageContext.request.contextPath}/addteacher" method="POST" id="addTeacherForm">
                <div class="form-container">
                    <div class="form-section">
                        <div class="section-header">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                 stroke-linecap="round" stroke-linejoin="round">
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

                        <div class="form-group full-width classroom-selection-group">
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

                    <div class="form-section security-section">
                        <div class="section-header">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                 stroke-linecap="round" stroke-linejoin="round">
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
                    selectedGrades = selectedGrades.filter(function(g) { return g !== grade; });
                } else {
                    this.classList.add('active');
                    selectedGrades.push(grade);
                }

                hiddenInput.value = selectedGrades.join(',');
            });
        });
    });
</script>
</body>
</html>

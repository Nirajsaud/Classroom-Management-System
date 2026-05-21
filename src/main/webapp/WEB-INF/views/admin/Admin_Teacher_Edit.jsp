<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Teacher – Pathshala</title>

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
                <h1 class="form-title">Edit Teacher Profile</h1>
            </div>

            <c:if test="${param.status eq 'error'}">
                <div class="page-alert error-alert">
                    Failed to modify teacher information. Check data parameters.
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

				<form action="${pageContext.request.contextPath}/teachers/edit" method="POST" id="editTeacherForm">
                <input type="hidden" name="teacherId" value="${teacher.teacherId}">
                <input type="hidden" name="userId" value="${teacher.userId}">

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
                                <input type="text" name="fullName" value="<c:out value='${teacher.fullName}'/>" required="required">
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input type="email"
                                       name="email"
                                       value="<c:out value='${teacher.email}'/>"
                                       required="required"
                                       readonly="readonly"
                                       style="background-color: #F1F5F9; border: 1px solid #CBD5E1; color: #64748B; cursor: not-allowed;">
                            </div>

                            <div class="form-group">
                                <label>Primary Subject</label>
                                <select name="subject" id="subjectDropdown" required="required">
                                    <option value="Nepali" ${teacher.subject == 'Nepali' ? 'selected' : ''}>Nepali</option>
                                    <option value="English" ${teacher.subject == 'English' ? 'selected' : ''}>English</option>
                                    <option value="Science" ${teacher.subject == 'Science' ? 'selected' : ''}>Science</option>
                                    <option value="Math" ${teacher.subject == 'Math' ? 'selected' : ''}>Math</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="tel" name="phone" value="<c:out value='${teacher.phone}'/>" required="required">
                            </div>
                        </div>

                        <div class="form-group full-width classroom-selection-group">
                            <label>Assigned Classrooms (Toggle active selections)</label>
                            <input type="hidden" name="assignedClasses" id="hiddenClassesInput" value="${assignedGradesStr}">

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
                </div>

                <div class="form-footer">
                    <button type="submit" class="btn-create">Save Changes</button>
                </div>
            </form>
        </main>
    </div>
</div>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        const buttons = document.querySelectorAll('#gradeButtonGroup .classroom-btn');
        const hiddenInput = document.getElementById('hiddenClassesInput');
        let selectedGrades = hiddenInput.value ? hiddenInput.value.split(',') : [];

        buttons.forEach(function(btn) {
            const grade = btn.getAttribute('data-grade');

            if (selectedGrades.includes(grade)) {
                btn.classList.add('active');
            }

            btn.addEventListener('click', function() {
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

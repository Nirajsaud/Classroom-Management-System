<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${className} – Pathshala</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Amin_Classroom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="app-wrapper">
    <% request.setAttribute("activePage", "classrooms"); %>
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/adminTopbar.jsp" />

        <main class="content-area">
				<div class="form-header">
					<a href="${pageContext.request.contextPath}/classrooms"
						class="btn-cancel">Back</a>
					<h1 class="form-title">Classroom Details</h1>
				</div>

				<c:if test="${not empty param.status}">
					<div
						class="${param.status eq 'price_updated' || param.status eq 'subject_added' || param.status eq 'subject_deleted' 
                ? 'page-alert success-alert' 
                : 'page-alert validation-alert'}">

						<c:choose>
							<c:when test="${param.status eq 'missing_action'}">
                No classroom action was selected.
            </c:when>

							<c:when test="${param.status eq 'missing_price'}">
                Please enter a classroom price.
            </c:when>

							<c:when test="${param.status eq 'invalid_price'}">
                Price must be a valid number.
            </c:when>

							<c:when test="${param.status eq 'negative_price'}">
                Price cannot be negative.
            </c:when>

							<c:when test="${param.status eq 'missing_subject'}">
                Please enter a subject name.
            </c:when>

							<c:when test="${param.status eq 'invalid_subject'}">
                Subject name must contain only letters and spaces.
            </c:when>

							<c:when test="${param.status eq 'invalid_action'}">
                Invalid classroom action.
            </c:when>

							<c:when test="${param.status eq 'price_updated'}">
                Classroom price updated successfully.
            </c:when>

							<c:when test="${param.status eq 'subject_added'}">
                Subject added successfully.
            </c:when>

							<c:when test="${param.status eq 'subject_deleted'}">
                Subject deleted successfully.
            </c:when>
						</c:choose>

					</div>
				</c:if>

				<div class="classroom-details-body">
					<div class="classroom-left-col">
						<div class="classroom-info-block">
							<label class="info-label">Total Students Enrolled</label>
							<div class="info-value-box">${totalStudents}</div>
						</div>

						<div class="classroom-info-block"
							style="background: #ffffff; padding: 1.2rem; border-radius: 10px; border: 1px solid #e5e7eb;">
							<label class="info-label"
								style="margin-bottom: 10px; display: block;">Update
								Classroom Price (Rs.)</label>
							<form
								action="${pageContext.request.contextPath}/classrooms/manage"
								method="POST"
								style="display: flex; gap: 10px; align-items: center;">
								<input type="hidden" name="action" value="updatePrice">
								<input type="hidden" name="classId" value="${classroom.id}">

								<input type="number" name="newPrice" class="price-input"
									value="${price}" min="0" step="0.01">
								<button type="submit" class="btn-save-price">Save Price</button>
							</form>
						</div>
					</div>

					<div class="classroom-right-col">
						<div class="subjects-table-card">

							<div class="subjects-table-header">
								<span>Subject</span> <span>Action</span>
							</div>

							<c:forEach var="subject" items="${subjects}">
								<div class="subjects-table-row">
									<span>${subject}</span>
									<form
										action="${pageContext.request.contextPath}/classrooms/manage"
										method="POST" style="margin: 0;">
										<input type="hidden" name="action" value="deleteSubject">
										<input type="hidden" name="classId" value="${classroom.id}">
										<input type="hidden" name="subjectName" value="${subject}">

										<button type="submit" class="btn-delete-subject"
											onclick="return confirm('Are you sure you want to remove this subject?');">Delete</button>
									</form>
								</div>
							</c:forEach>

							<div class="subjects-table-add">
								<form
									action="${pageContext.request.contextPath}/classrooms/manage"
									method="POST" style="display: flex; gap: 10px; width: 100%;">
									<input type="hidden" name="action" value="addSubject">
									<input type="hidden" name="classId" value="${classroom.id}">

									<input type="text" name="subjectName" class="subject-input"
										placeholder="Enter new subject name" required>
									<button type="submit" class="btn-add-subject">Add
										Subject</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</main>
    </div>
</div>
</body>
</html>
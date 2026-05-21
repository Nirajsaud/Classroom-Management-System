<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact – Pathshala</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin_Contact.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"></head>

<body>
<div class="app-wrapper">
    <% request.setAttribute("activePage", "contact"); %>
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/adminTopbar.jsp" />

			<main class="content-area admin-contact-page">

				<div class="page-header">
					<div>
						<h1 class="page-title-large">Contact Submission</h1>
						<p class="page-subtitle">Review and manage inquiries sent
							through the Pathshala platform</p>
					</div>
				</div>

				<section class="contact-table-card">
					<div class="contact-header-row">
						<div>Date / Time</div>
						<div>Sender Details</div>
						<div>Phone Number</div>
						<div>Message</div>
						<div>Action</div>
					</div>

					<c:choose>
						<c:when test="${empty submissions}">
							<div class="empty-contact-row">No contact submissions
								found.</div>
						</c:when>

						<c:otherwise>
							<c:forEach var="submission" items="${submissions}">
								<div class="contact-row">
									<div>
										<div class="date-txt">
											<c:out value="${submission.date}" />
										</div>
										<div class="time-txt">
											<c:out value="${submission.time}" />
										</div>
									</div>

									<div>
										<div class="user-name">
											<c:out value="${submission.name}" />
										</div>
										<div class="user-email">
											<c:out value="${submission.email}" />
										</div>
									</div>

									<div>
										<span class="phone-tag"><c:out
												value="${submission.phone}" /></span>
									</div>

									<div>
										<p class="msg-preview">
											<c:out value="${submission.messageSnippet}" />
										</p>
									</div>

									<div>
										<form action="${pageContext.request.contextPath}/admincontact"
											method="POST"
											onsubmit="return confirm('Permanently delete this inquiry?');">
											<input type="hidden" name="queryId"
												value="${submission.queryId}"> <input type="hidden"
												name="action" value="delete">
											<button class="bin-btn" type="submit">Bin</button>
										</form>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</section>

			</main>
		</div>
</div>

<script src="${pageContext.request.contextPath}/js/Admin_Contact.js"></script>
</body>
</html>
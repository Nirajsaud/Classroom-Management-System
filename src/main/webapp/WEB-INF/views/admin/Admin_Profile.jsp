<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile – Pathshala</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacherProfile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>

<div class="app-wrapper">
    <% request.setAttribute("activePage", "profile"); %>
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/adminTopbar.jsp" />

			<main class="profile-container">
				<section class="profile-header">
					<h1>Admin Profile</h1>
                <p>Manage your personal information and account details.</p>
				</section>

				<c:if test="${not empty message}">
					<div
						style="padding: 14px; margin-bottom: 20px; background-color: #dcfce7; color: #166534; border-radius: 8px; border: 1px solid #bbf7d0;">
						${message}</div>
					<c:remove var="message" scope="session" />
				</c:if>

				<c:if test="${not empty error}">
					<div
						style="padding: 14px; margin-bottom: 20px; background-color: #fee2e2; color: #b91c1c; border-radius: 8px; border: 1px solid #fecaca;">
						${error}</div>
					<c:remove var="error" scope="session" />
				</c:if>

				<section class="profile-card">
					<div class="profile-photo-area">
						<div class="profile-photo">
							<img id="imagePreview"
								src="${pageContext.request.contextPath}/getimage?name=${user.email}"
								alt="Profile Preview"
								onerror="this.style.display='none'; document.getElementById('placeholderIcon').style.display='block';">

							<i class="fa-solid fa-user" id="placeholderIcon"></i>
						</div>

						<label for="profileImage" class="photo-btn">Change Photo</label>
					</div>

					<form action="${pageContext.request.contextPath}/profile"
						method="post" enctype="multipart/form-data" class="profile-form">

						<input type="file" id="profileImage" name="profilePhoto"
							accept="image/*" hidden onchange="previewFile()">

						<div class="form-title">
							<i class="fa-solid fa-user-pen"></i>
							<h2>Personal Details</h2>
						</div>

						<div class="form-grid">
							<div class="form-group">
								<label for="fullName">FULL NAME</label> <input type="text"
									id="fullName" name="fullName" value="${user.fullName}" required>
							</div>

							<div class="form-group">
								<label for="phoneNumber">PHONE NUMBER</label> <input type="text"
									id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}"
									required>
							</div>

							<div class="form-group full-width">
								<label for="email">EMAIL ADDRESS</label> <input type="email"
									id="email" name="email" value="${user.email}" readonly
									style="background-color: #F1F5F9; border: 1px solid #CBD5E1; color: #64748B; cursor: not-allowed;">
							</div>
						</div>

						<div class="form-actions">
							<button type="reset" class="cancel-btn" onclick="resetPreview()">Cancel
								Changes</button>
							<button type="submit" class="save-btn">Save Changes</button>
						</div>
					</form>
				</section>
			</main>

			<script>
    const initialAvatarSrc = document.getElementById("imagePreview").src;

    function previewFile() {
        const preview = document.getElementById("imagePreview");
        const placeholder = document.getElementById("placeholderIcon");
        const fileInput = document.querySelector("input[name='profilePhoto']");
        const file = fileInput.files[0];

        if (!file) {
            return;
        }

        const reader = new FileReader();

        reader.onloadend = function () {
            preview.src = reader.result;
            preview.style.display = "block";
            if (placeholder) {
                placeholder.style.display = "none";
            }
        };

        reader.readAsDataURL(file);
    }

    function resetPreview() {
        const preview = document.getElementById("imagePreview");
        const placeholder = document.getElementById("placeholderIcon");

        preview.src = initialAvatarSrc;
        preview.style.display = "block";

        if (placeholder) {
            placeholder.style.display = "none";
        }
    }
</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Student Profile</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/studentProfile.css">
</head>
<body>

<header class="main-nav">

    <div class="nav-container">

        <div class="logo-area">
            <span class="pathshala-logo">pathshala</span>
        </div>

        <nav class="center-links">

            <a href="${pageContext.request.contextPath}/dashboard"
               class="nav-link">

                <i class="fa-solid fa-table-cells-large"></i>
                Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/student/classroom"
               class="nav-link">

                <i class="fa-solid fa-pen-nib"></i>
                Classrooms
            </a>

            <a href="${pageContext.request.contextPath}/student/subjects"
               class="nav-link">

                <i class="fa-solid fa-book"></i>
                Subjects
            </a>

            <a href="${pageContext.request.contextPath}/student/payment"
               class="nav-link">

                <i class="fa-solid fa-wallet"></i>
                Payment
            </a>

        </nav>

        <div class="user-controls">

            <i class="fa-regular fa-bell bell-icon"></i>

            <div class="v-divider"></div>

            <a href="${pageContext.request.contextPath}/student/profile"
               class="profile-icon active-profile">

                <i class="fa-solid fa-user"></i>
            </a>

            <a href="${pageContext.request.contextPath}/logout"
               class="logout-btn">

                Logout
            </a>

        </div>

    </div>

</header>

<main class="profile-container">

    <section class="profile-header">

        <h1>Student Profile</h1>

        <p>
            Manage your personal information and account details.
        </p>

    </section>

    <section class="profile-card">

        <div class="profile-photo-area">

            <div class="profile-photo">

                <i class="fa-solid fa-user"
                   id="placeholderIcon"></i>

                <img id="imagePreview"
                     src="#"
                     alt="Profile Preview">

            </div>

            <label for="profileImage"
                   class="photo-btn">

                Change Photo
            </label>

        </div>

        <form action="${pageContext.request.contextPath}/student/profile"
              method="post"
              enctype="multipart/form-data"
              class="profile-form">

            <input type="file"
                   id="profileImage"
                   name="profileImage"
                   accept="image/*"
                   hidden
                   onchange="previewFile()">

            <div class="form-title">

                <i class="fa-solid fa-user-pen"></i>

                <h2>Personal Details</h2>

            </div>

            <div class="form-grid">

                <div class="form-group">

                    <label for="fullName">
                        FULL NAME
                    </label>

                    <input type="text"
                           id="fullName"
                           name="fullName"
                           value="${user.fullName}">

                </div>

                <div class="form-group">

                    <label for="phoneNumber">
                        PHONE NUMBER
                    </label>

                    <input type="text"
                           id="phoneNumber"
                           name="phoneNumber"
                           value="${user.phoneNumber}">

                </div>

                <div class="form-group full-width">

                    <label for="email">
                        EMAIL ADDRESS
                    </label>

                    <input type="email"
                           id="email"
                           name="email"
                           value="${user.email}">

                </div>

            </div>

            <div class="form-actions">

                <a href="${pageContext.request.contextPath}/dashboard"
                   class="cancel-btn">

                    Cancel Changes
                </a>

                <button type="submit"
                        class="save-btn">

                    Save Changes
                </button>

            </div>

        </form>

    </section>

</main>

<script>

    function previewFile() {

        const preview =
            document.getElementById('imagePreview');

        const file =
            document.querySelector('input[name=profileImage]').files[0];

        const reader =
            new FileReader();

        const placeholder =
            document.getElementById('placeholderIcon');

        reader.onloadend = function () {

            preview.src = reader.result;

            preview.style.display = 'block';

            placeholder.style.display = 'none';
        }

        if (file) {
            reader.readAsDataURL(file);
        }
    }

</script>

</body>
</html>
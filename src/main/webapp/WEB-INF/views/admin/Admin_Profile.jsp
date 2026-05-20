<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile – Pathshala</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin_Profile.css">
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

            <a href="${pageContext.request.contextPath}/teachers" class="nav-item">
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
                <a href="${pageContext.request.contextPath}/approvals" class="bell-btn" title="Pending Approvals" style="display: flex; align-items: center; text-decoration: none; position: relative;">
                    <svg class="bell-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width: 24px; height: 24px; color: #111827;">
                        <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9" />
                        <path d="M13.73 21a2 2 0 0 1-3.46 0" />
                    </svg> 
                    <c:if test="${pendingCount > 0}">
                        <span class="bell-badge" style="position: absolute; top: -2px; right: -2px; width: 10px; height: 10px; background: #ef4444; border-radius: 50%;"></span>
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
            <a href="${pageContext.request.contextPath}/logout-user" class="logout-btn" style="text-decoration: none; display: inline-flex; align-items: center; justify-content: center;">
                Logout
            </a>
        </header>

        <main class="content-area">

            <h1 class="profile-page-title">Admin Profile</h1>

            <c:if test="${not empty message}">
                <div style="padding: 14px; margin-bottom: 20px; background-color: #142e1a; color: #4ade80; border-radius: 8px; border: 1px solid rgba(74,222,128,0.2); font-size: 0.95rem;">
                    ${message}
                </div>
                <c:remove var="message" scope="session"/>
            </c:if>
            <c:if test="${not empty error}">
                <div style="padding: 14px; margin-bottom: 20px; background-color: #3c1818; color: #f87171; border-radius: 8px; border: 1px solid rgba(248,113,113,0.2); font-size: 0.95rem;">
                    ${error}
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <form class="profile-card"
                  action="${pageContext.request.contextPath}/profile"
                  method="post"
                  enctype="multipart/form-data">

                <div class="profile-photo-col">
                    <div class="profile-photo-wrap">
                        <img src="${not empty profilePhotoPath
                                    ? pageContext.request.contextPath.concat('/').concat(profilePhotoPath)
                                    : 'https://via.placeholder.com/160'}"
                             alt="Admin Photo"
                             class="profile-photo"
                             id="avatarPreview">
                        <label class="photo-edit-btn" for="photoInput" title="Change photo">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                 stroke-linecap="round" stroke-linejoin="round">
                                <path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8
                                         a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"/>
                                <circle cx="12" cy="13" r="4"/>
                            </svg>
                        </label>
                        <input type="file" id="photoInput" name="profilePhoto" accept="image/*" onchange="handleImagePreview(this)">
                    </div>
                </div>

                <div class="profile-form-col">

                    <div class="profile-section-heading">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                             stroke-linecap="round" stroke-linejoin="round" width="18" height="18">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                            <circle cx="12" cy="7" r="4"/>
                        </svg>
                        <span>Personal Details</span>
                    </div>

                    <div class="profile-fields">
                        <div class="profile-field-group">
                            <label class="field-label" for="fullName">FULL NAME</label>
                            <input class="field-input" type="text" id="fullName" name="fullName" value="${user.fullName}" required>
                        </div>
                        <div class="profile-field-group">
                            <label class="field-label" for="phoneNumber">PHONE NUMBER</label>
                            <input class="field-input" type="tel" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" required>
                        </div>
                        <div class="profile-field-group">
                            <label class="field-label" for="email">EMAIL</label>
                            <input class="field-input" type="email" id="email" name="email" value="${user.email}" readonly>
                        </div>
                    </div>

                    <div class="profile-actions">
                        <button class="btn-cancel-changes" type="reset" onclick="resetImagePreview()">Cancel Changes</button>
                        <button class="btn-save-changes" type="submit">Save Changes</button>
                    </div>

                </div>
            </form>

        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/Admin_Profile.js"></script>
<script>
    // Live Client-Side Image Preview Logic
    const initialAvatarSrc = document.getElementById("avatarPreview").src;
    
    function handleImagePreview(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById("avatarPreview").src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    function resetImagePreview() {
        // Restores view components to load default state values
        document.getElementById("avatarPreview").src = initialAvatarSrc;
    }
</script>
</body>
</html>
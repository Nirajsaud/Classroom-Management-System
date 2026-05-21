<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="main-nav">
    <div class="nav-container">
        <div class="logo-area">
            <span class="pathshala-logo">pathshala</span>
        </div>

        <nav class="center-links">
            <a href="${pageContext.request.contextPath}/dashboard"
               class="nav-link ${activePage eq 'dashboard' ? 'active' : ''}">
                <i class="fa-solid fa-table-cells-large"></i> Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/classrooms"
               class="nav-link ${activePage eq 'classrooms' ? 'active' : ''}">
                <i class="fa-solid fa-pen-nib"></i> Classrooms
            </a>

            <a href="${pageContext.request.contextPath}/students"
               class="nav-link ${activePage eq 'students' ? 'active' : ''}">
                <i class="fa-solid fa-book-open"></i> Students
            </a>
        </nav>

        <div class="user-controls">
            <div class="bell-wrapper" id="bellWrapper">
                <button type="button" class="bell-btn" id="bellBtn" aria-label="Open notifications">
                    <i class="fa-regular fa-bell"></i>
                </button>

                <c:if test="${not empty noticeList}">
                    <span class="bell-badge" id="bellBadge"></span>
                </c:if>

                <div class="notif-dropdown" id="notifDropdown">
                    <div class="notif-header">
                        <h4>Notifications</h4>
                        <button type="button" class="notif-mark-all" id="markAllRead">Dismiss all</button>
                    </div>

                    <div class="notif-list" id="notifList">
                        <c:choose>
                            <c:when test="${empty noticeList}">
                                <div class="notif-footer">
                                    <p>No notifications yet.</p>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <c:forEach var="notice" items="${noticeList}">
                                    <div class="notif-item unread">
                                        <div class="notif-dot"></div>

                                        <div class="notif-content">
                                            <div class="notif-title">${notice.title}</div>
                                            <div class="notif-text">${notice.content}</div>
                                            <div class="notif-time">${notice.createdAt}</div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="v-divider"></div>

            <a href="${pageContext.request.contextPath}/profile"
               class="profile-icon ${activePage eq 'profile' ? 'profile-active' : ''}"
               aria-label="Open profile">
                <img src="${pageContext.request.contextPath}/getimage?name=${user.email}"
                     alt="Profile"
                     class="nav-profile-image"
                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">

                <div class="default-profile-icon">
                    <i class="fa-solid fa-user"></i>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/logout-user" class="logout-btn">Logout</a>
        </div>
    </div>
</header>

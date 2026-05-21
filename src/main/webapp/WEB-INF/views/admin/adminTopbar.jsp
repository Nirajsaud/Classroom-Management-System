<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="topbar">
    <a href="${pageContext.request.contextPath}/approvals"
       class="admin-bell-btn ${activePage == 'approvals' ? 'active' : ''}"
       title="Pending Approvals"
       aria-label="Pending Approvals">
        <svg class="bell-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/>
            <path d="M13.73 21a2 2 0 0 1-3.46 0"/>
        </svg>
        <c:if test="${pendingCount > 0}">
            <span class="bell-badge"></span>
        </c:if>
    </a>

    <div class="topbar-divider"></div>

    <a href="${pageContext.request.contextPath}/profile" class="user-avatar ${activePage == 'profile' ? 'active' : ''}" title="Profile">
        <img src="${pageContext.request.contextPath}/getimage?name=${user.email}"
             alt="Profile"
             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
        <span class="avatar-fallback">
            <i class="fa-solid fa-user"></i>
        </span>
    </a>

    <a href="${pageContext.request.contextPath}/logout-user" class="logout-btn">Logout</a>
</header>

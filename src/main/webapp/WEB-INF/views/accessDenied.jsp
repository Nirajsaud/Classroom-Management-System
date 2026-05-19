<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Access Restricted</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/acccessDenied.css" />
</head>
<body>

    <div class="denied-card">
        <div class="icon-wrap">
            <svg xmlns="http://www.w3.org/2000/svg"
                 fill="none"
                 viewBox="0 0 24 24"
                 stroke="currentColor"
                 stroke-width="2.2"
                 stroke-linecap="round"
                 stroke-linejoin="round">
                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                <circle cx="12" cy="16" r="1" fill="currentColor" stroke="none"/>
            </svg>
        </div>

        <h1 class="denied-title">Access Restricted</h1>

        <p class="denied-desc">
            You do not have permission to
            <br>
            view this page
        </p>

        <a href="javascript:history.back()" class="btn-return">
            <span class="arrow">&#8592;</span>
            Return
        </a>

        <div class="error-actions">
            <a href="${pageContext.request.contextPath}/contact" class="contact-link">

                Contact Administration
            </a>
        </div>
    </div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Page Not Found | Pathshala</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/acccessDenied.css" />
    <style>
        /* Small styling overrides to make the icon fit a 404 look perfectly */
        .icon-wrap svg {
            color: #ef4444; /* Alert color shade variation */
        }
    </style>
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
                <circle cx="12" cy="12" r="10"/>
                <polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76"/>
            </svg>
        </div>

        <h1 class="denied-title">404 - Not Found</h1>

        <p class="denied-desc">
            The link you followed may be broken,
            <br>
            or the page has been moved.
        </p>

        <a href="${pageContext.request.contextPath}/home" class="btn-return">
            <span class="arrow">&#8592;</span>
            Go to Home Screen
        </a>

        <div class="error-actions">
            <a href="${pageContext.request.contextPath}/contact" class="contact-link">
                Report a broken link
            </a>
        </div>
    </div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Student Dashboard</title>
    
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icons: FontAwesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentDashboard.css">
</head>
<body>

    <!-- Nav Bar: 3-Zone Layout -->
    <nav class="dash-nav">
        <div class="nav-left">
            <span class="logo">pathshala</span>
        </div>
        
        <div class="nav-center">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item active">
                <i class="fa-solid fa-table-cells-large"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/classrooms" class="nav-item">
                <i class="fa-solid fa-pen-nib"></i> Classrooms
            </a>
            <a href="${pageContext.request.contextPath}/subjects" class="nav-item">
                <i class="fa-solid fa-book"></i> Subjects
            </a>
            <a href="${pageContext.request.contextPath}/payments" class="nav-item">
                <i class="fa-solid fa-wallet"></i> Payment
            </a>
            
        </div>
        
        <div class="nav-right">
            <div class="action-icons">
                <i class="fa-regular fa-bell bell-icon"></i>
                <div class="nav-divider"></div>
                <div class="profile-box">
                    <i class="fa-solid fa-user"></i>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        </div>
    </nav>

    <!-- Main Dashboard Content -->
    <main class="dashboard-container">
        
        <header class="welcome-section">
            <h1>Welcome Back, <span class="underlined-name">${user.fullName}</span></h1>
            <p>What would you like to do today?</p>
        </header>

        <!-- Clickable Action Cards -->
        <section class="action-grid">
            <a href="${pageContext.request.contextPath}/subjects" class="card card-subjects">
                <div class="card-header">
                    <h2>Subjects</h2>
                </div>
                <div class="card-body">
                    <p>View and access materials status, from the classroom you have paid for.</p>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/classrooms" class="card card-classrooms">
                <div class="card-header">
                    <h2>Classrooms</h2>
                </div>
                <div class="card-body">
                    <p>Browse available classroom packages from Grade 4 to 10 and purchase the ones you want to join.</p>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/payments" class="card card-payments">
                <div class="card-header">
                    <h2>My Payments</h2>
                </div>
                <div class="card-body">
                    <p>Check your payments expiry date and renew classroom subscriptions before you get locked.</p>
                </div>
            </a>
        </section>

        <!-- Notification Panel -->
        <section class="notification-panel">
            <div class="notif-title">
                <h2>Notification</h2>
            </div>
            <div class="notif-content">
                <!-- Static for now, will be dynamic in backend phase -->
                <div class="notif-row">
                    <span class="timestamp">3 Days ago</span>
                    <p class="message">Rabina lama added a new video to class 5 science</p>
                </div>
                <div class="notif-row">
                    <span class="timestamp">5 Days ago</span>
                    <p class="message">Rabina lama added a new pdf to class 5 science</p>
                </div>
            </div>
        </section>

    </main>

</body>
</html>
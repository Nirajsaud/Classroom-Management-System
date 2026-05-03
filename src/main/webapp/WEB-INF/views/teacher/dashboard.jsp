<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Teacher Dashboard</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="../css/teacherDashboard.css">
</head>
<body>

    <!-- Header / Navbar -->
    <header class="main-nav">
        <div class="nav-container">
            <div class="logo-area">
                <span class="pathshala-logo">pathshala</span>
            </div>
            
            <nav class="center-links">
                <a href="#" class="nav-link active"><i class="fa-solid fa-table-cells-large"></i> Dashboard</a>
                <a href="#" class="nav-link"><i class="fa-solid fa-pen-nib"></i> Classrooms</a>
                <a href="#" class="nav-link"><i class="fa-solid fa-book-open"></i> Teaching Resources</a>
            </nav>
            
            <div class="user-controls">
                <i class="fa-regular fa-bell bell-icon"></i>
                <div class="v-divider"></div>
                <div class="profile-icon"><i class="fa-solid fa-user"></i></div>
                <a href="logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </header>

    <main class="dashboard-container">
        <!-- Welcome Section -->
        <section class="welcome-section">
            <h1>Welcome Back, <span class="teacher-name">Teacher Name</span></h1>
            <p>What would you like to do today?</p>
        </section>

        <!-- Feature Cards -->
        <section class="cards-grid">
            <a href="classrooms.html" class="feature-card card-blue">
                <h2>Classroom</h2>
                <div class="card-divider"></div>
                <div class="card-body">
                    <h3>Assigned Classroom</h3>
                    <p>Check your assigned classroom and all the dashboard of the classroom you are assigned to.</p>
                </div>
            </a>

            <a href="students.html" class="feature-card card-orange">
                <h2>Students</h2>
                <div class="card-divider"></div>
                <div class="card-body">
                    <h3>Student's Activity</h3>
                    <p>Check how many times a student login.</p>
                </div>
            </a>

            <a href="resources.html" class="feature-card card-navy">
                <h2>Teaching Resources</h2>
                <div class="card-divider"></div>
                <div class="card-body">
                    <h3>Create Testpaper</h3>
                    <p>Review the teaching manuals, interactive videos, worksheets, eTestbooks for subject that you are teaching.</p>
                </div>
            </a>
        </section>

        <!-- Notice Board -->
        <section class="notice-board">
            <h2>Notice Board</h2>
            <div class="board-content">
                <div class="notice-item">
                    <span class="timestamp">3 Days ago</span>
                    <p>Rabina lama added a new video to class 5 science</p>
                </div>
                <div class="notice-item">
                    <span class="timestamp">5 Days ago</span>
                    <p>Rabina lama added a new pdf to class 5 science</p>
                </div>
            </div>
        </section>
    </main>

</body>
</html>
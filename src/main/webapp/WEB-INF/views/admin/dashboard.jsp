<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala Admin | Responsive Dashboard</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="../css/adminDashboard.css">
</head>
<body>

    <div class="admin-layout">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-brand">
                <span class="logo">pathshala</span>
            </div>
            
            <nav class="sidebar-menu">
                <a href="#" class="menu-item active"><i class="fa-solid fa-table-cells-large"></i> Dashboard</a>
                <a href="#" class="menu-item"><i class="fa-solid fa-graduation-cap"></i> Teachers</a>
                <a href="#" class="menu-item"><i class="fa-solid fa-user-group"></i> Students</a>
                <a href="#" class="menu-item"><i class="fa-solid fa-pen-nib"></i> Classrooms</a>
                <a href="#" class="menu-item"><i class="fa-solid fa-file-lines"></i> Report</a>
            </nav>
        </aside>

        <!-- Main Wrapper -->
        <div class="main-wrapper">
            <header class="admin-header">
                <div class="header-right">
                    <i class="fa-regular fa-bell bell-icon"></i>
                    <div class="v-divider"></div>
                    <div class="profile-box"><i class="fa-solid fa-user"></i></div>
                    <a href="logout" class="logout-link">Logout</a>
                </div>
            </header>

            <main class="admin-content">
                <!-- Top Stats -->
                <section class="stats-grid">
                    <div class="stat-card card-blue">
                        <div class="stat-text">
                            <p>Total Students</p>
                            <h3>1,284</h3>
                        </div>
                        <div class="stat-icon"><i class="fa-solid fa-user"></i></div>
                    </div>
                    <div class="stat-card card-orange">
                        <div class="stat-text">
                            <p>Total Teachers</p>
                            <h3>72</h3>
                        </div>
                        <div class="stat-icon"><i class="fa-solid fa-user-group"></i></div>
                    </div>
                    <div class="stat-card card-green">
                        <div class="stat-text">
                            <p>Payment Collected</p>
                            <h3>Rs 4,52,390</h3>
                        </div>
                        <div class="stat-icon"><i class="fa-solid fa-money-bill-wave"></i></div>
                    </div>
                </section>

                <!-- Visualization Area -->
                <section class="visual-layout">
                    <div class="progress-panel">
                        <h2>Students per Classroom</h2>
                        <div class="progress-list">
                            <!-- Grade 4 to 10 -->
                            <div class="bar-row">
                                <div class="bar-label label-orange">Grade 4 | 121</div>
                                <div class="bar-track"><div class="bar-fill fill-orange" style="width: 35%;"></div></div>
                            </div>
                            <div class="bar-row">
                                <div class="bar-label label-blue">Grade 5 | 200</div>
                                <div class="bar-track"><div class="bar-fill fill-blue" style="width: 50%;"></div></div>
                            </div>
                            <div class="bar-row">
                                <div class="bar-label label-navy">Grade 6 | 154</div>
                                <div class="bar-track"><div class="bar-fill fill-navy" style="width: 42%;"></div></div>
                            </div>
                            <div class="bar-row">
                                <div class="bar-label label-blue">Grade 7 | 82</div>
                                <div class="bar-track"><div class="bar-fill fill-blue" style="width: 25%;"></div></div>
                            </div>
                            <div class="bar-row">
                                <div class="bar-label label-orange">Grade 8 | 346</div>
                                <div class="bar-track"><div class="bar-fill fill-orange" style="width: 85%;"></div></div>
                            </div>
                            <div class="bar-row">
                                <div class="bar-label label-navy">Grade 9 | 114</div>
                                <div class="bar-track"><div class="bar-fill fill-navy" style="width: 30%;"></div></div>
                            </div>
                            <div class="bar-row">
                                <div class="bar-label label-orange">Grade 10 | 309</div>
                                <div class="bar-track"><div class="bar-fill fill-orange" style="width: 78%;"></div></div>
                            </div>
                        </div>
                    </div>

                    <div class="reg-summary">
                        <p>Total registration</p>
                        <h2 class="huge-number">1385</h2>
                    </div>
                </section>
            </main>
        </div>
    </div>

</body>
</html>
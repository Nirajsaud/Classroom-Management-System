<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Student Subjects</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentSubject.css">
</head>
<body>

    <header class="main-nav">
        <div class="nav-container">
            <div class="logo-area">
                <span class="pathshala-logo">pathshala</span>
            </div>

            <nav class="center-links">
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                    <i class="fa-solid fa-table-cells-large"></i> Dashboard
                </a>

                <a href="${pageContext.request.contextPath}/student/classroom" class="nav-link">
                    <i class="fa-solid fa-pen-nib"></i> Classrooms
                </a>

                <a href="${pageContext.request.contextPath}/student/subjects" class="nav-link active">
                    <i class="fa-solid fa-book"></i> Subjects
                </a>

                <a href="${pageContext.request.contextPath}/student/payment" class="nav-link">
                    <i class="fa-solid fa-wallet"></i> Payment
                </a>
            </nav>

            <div class="user-controls">
                <i class="fa-regular fa-bell bell-icon"></i>
                <div class="v-divider"></div>

                <a href="${pageContext.request.contextPath}/student/profile" class="profile-icon">
                    <i class="fa-solid fa-user"></i>
                </a>

                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </header>

    <main class="subject-page">

        <section class="top-controls">
            <select class="filter-select" name="grade">
                <option>Grade 5</option>

            </select>

            <select class="filter-select" name="subject">
                <option>English</option>
                <option>Science</option>
                <option>Mathematics</option>
                <option>Computer Science</option>
            </select>
        </section>

        <section class="subject-panel">
            <div class="tab-buttons">
                <button type="button" class="tab-btn active" data-tab="study">Study Resources</button>
                <button type="button" class="tab-btn" data-tab="lecture">Lecture Video</button>
                <button type="button" class="tab-btn" data-tab="practice">Practice Questions</button>
            </div>

            <div class="resource-box">

                <div class="tab-content active" id="study">
                    <div class="resource-item">
                        <div class="resource-text">
                            <h3>Chapter 4</h3>
                            <p>Questions and answers for grammar practice</p>
                        </div>

                        <div class="resource-meta">
                            <span>Created at: 2026-01-23</span>
                            <a href="#" class="download-btn">Download</a>
                        </div>
                    </div>

                    <div class="resource-item">
                        <div class="resource-text">
                            <h3>Chapter 4</h3>
                            <p>Guides on writing an email</p>
                        </div>

                        <div class="resource-meta">
                            <span>Created at: 2026-01-23</span>
                            <a href="#" class="download-btn">Download</a>
                        </div>
                    </div>
                </div>

                <div class="tab-content" id="lecture">
                    <div class="resource-item video-item">
                        <div class="resource-text video-title">
                            <i class="fa-regular fa-square-play"></i>
                            <p>How to write an email</p>
                        </div>

                        <div class="resource-meta">
                            <span>Created at: 2026-01-23</span>
                            <a href="#" class="watch-btn">Watch</a>
                        </div>
                    </div>

                    <div class="resource-item video-item">
                        <div class="resource-text video-title">
                            <i class="fa-regular fa-square-play"></i>
                            <p>How to write an essay</p>
                        </div>

                        <div class="resource-meta">
                            <span>Created at: 2026-01-23</span>
                            <a href="#" class="watch-btn">Watch</a>
                        </div>
                    </div>
                </div>

                <div class="tab-content" id="practice">
                    <div class="practice-item">
                        <h3>Chapter 4: Story Writing</h3>

                        <div class="practice-right">
                            <span>Created at: 2026-01-23</span>
                            <a href="#" class="practice-download-btn">Download Practice Question</a>
                        </div>
                    </div>

                    <div class="practice-item">
                        <h3>Chapter 3: Letter Writing</h3>

                        <div class="practice-right">
                            <span>Created at: 2026-01-23</span>
                            <a href="#" class="practice-download-btn">Download Practice Question</a>
                        </div>
                    </div>
                </div>

            </div>
        </section>

    </main>

    <script src="${pageContext.request.contextPath}/js/studentSubject.js"></script>
</body>
</html>
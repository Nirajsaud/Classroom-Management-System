<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pathshala | Teacher Classroom</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacherClassroom.css">
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

                <a href="${pageContext.request.contextPath}/teacher/classroom" class="nav-link active">
                    <i class="fa-solid fa-pen-nib"></i> Classrooms
                </a>

                <a href="${pageContext.request.contextPath}/teacher/subjects" class="nav-link">
                    <i class="fa-regular fa-bookmark"></i> Subjects
                </a>

                <a href="${pageContext.request.contextPath}/teacher/payment" class="nav-link">
                    <i class="fa-regular fa-credit-card"></i> Payment
                </a>
            </nav>

            <div class="user-controls">
                <i class="fa-regular fa-bell bell-icon"></i>
                <div class="v-divider"></div>
                <div class="profile-icon">
                    <i class="fa-solid fa-user"></i>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </header>

    <main class="classroom-page">
        <section class="top-controls">
            <div class="filters">
                <select class="filter-select" name="grade">
                    <option>Grade 4</option>
                    <option>Grade 5</option>
                    <option>Grade 6</option>
                    <option>Grade 7</option>
                    <option>Grade 8</option>
                    <option>Grade 9</option>
                    <option>Grade 10</option>
                </select>

                <select class="filter-select" name="subject">
                    <option>English</option>

                </select>
            </div>

            <button type="button" class="upload-btn" id="openUploadBtn">Upload Material</button>
        </section>

        <section class="classroom-panel">
            <div class="tab-buttons">
                <button type="button" class="tab-btn active" data-tab="study">Study Resources</button>
                <button type="button" class="tab-btn" data-tab="lecture">Lecture video</button>
                <button type="button" class="tab-btn" data-tab="practice">Practice Questions</button>
            </div>

            <div class="resource-box">
                <div class="box-top">
                    <span></span>
                    <div class="student-count">4 Students</div>
                </div>

                <div class="box-divider"></div>

                <div class="tab-content active" id="study">
                    <div class="resource-item">
                        <div class="resource-text">
                            <h3>Chapter 4</h3>
                            <p>Questions and answers for grammar practice</p>
                        </div>

                        <div class="resource-meta">
                            <span>Created at: 2026-01-23</span>
                            <button type="button" class="delete-btn">Delete</button>
                        </div>
                    </div>

                    <div class="resource-item">
                        <div class="resource-text">
                            <h3>Chapter 4</h3>
                            <p>Guides on writing an email</p>
                        </div>

                        <div class="resource-meta">
                            <span>Created at: 2026-01-23</span>
                            <button type="button" class="delete-btn">Delete</button>
                        </div>
                    </div>
                </div>

                <div class="tab-content" id="lecture">
                    <div class="resource-item">
                        <div class="resource-text">
                            <h3>Lecture Video 1</h3>
                            <p>Introduction to sentence structure</p>
                        </div>

                        <div class="resource-meta">
                            <span>Created at: 2026-01-24</span>
                            <button type="button" class="delete-btn">Delete</button>
                        </div>
                    </div>

                    <div class="resource-item">
                        <div class="resource-text">
                            <h3>Lecture Video 2</h3>
                            <p>Email writing explanation video</p>
                        </div>

                        <div class="resource-meta">
                            <span>Created at: 2026-01-25</span>
                            <button type="button" class="delete-btn">Delete</button>
                        </div>
                    </div>
                </div>

                <div class="tab-content" id="practice">
                    <div class="resource-item">
                        <div class="resource-text">
                            <h3>Practice Set 1</h3>
                            <p>Email writing practice questions</p>
                        </div>

                        <div class="resource-meta">
                            <span>Created at: 2026-01-26</span>
                            <button type="button" class="delete-btn">Delete</button>
                        </div>
                    </div>

                    <div class="resource-item">
                        <div class="resource-text">
                            <h3>Practice Set 2</h3>
                            <p>Grammar worksheet for classroom practice</p>
                        </div>

                        <div class="resource-meta">
                            <span>Created at: 2026-01-27</span>
                            <button type="button" class="delete-btn">Delete</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <div class="upload-overlay" id="uploadOverlay">
        <div class="upload-modal">
            <form action="${pageContext.request.contextPath}/teacher/upload-material" method="post" enctype="multipart/form-data">

                <label for="materialFile" class="upload-drop-area">
    				<i class="fa-solid fa-arrow-up-from-bracket" id="uploadIcon"></i>

    					<span id="uploadText">
      						  Drag & Drop or <strong>Choose file</strong> to upload
    					</span>

    <input type="file" id="materialFile" name="materialFile" hidden>
</label>

                <textarea name="description" placeholder="Add description about the uploaded file."></textarea>

                <div class="upload-select-row">
                    <div class="upload-select-group">
                        <label>Choose Classroom</label>
                        <select name="classroom">
                            <option>Classroom</option>
                            <option>Grade 4</option>
                            <option>Grade 5</option>
                            <option>Grade 6</option>
                            <option>Grade 7</option>
                            <option>Grade 8</option>
                            <option>Grade 9</option>
                            <option>Grade 10</option>
                        </select>
                    </div>

                    <div class="upload-select-group">
                        <label>Choose Type</label>
                        <select name="type">
                            <option>Type</option>
                            <option>Study Resources</option>
                            <option>Lecture Video</option>
                            <option>Practice Questions</option>
                        </select>
                    </div>
                </div>

                <div class="upload-actions">
                    <button type="button" class="cancel-upload-btn" id="cancelUploadBtn">Cancel</button>
                    <button type="submit" class="submit-upload-btn">Upload</button>
                </div>

            </form>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/teacherClassroom.js"></script>
</body>
</html>
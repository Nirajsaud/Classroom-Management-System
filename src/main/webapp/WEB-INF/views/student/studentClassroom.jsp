<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pathshala | Student Classrooms</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: white;
            color: #111;
        }

        .navbar {
            height: 48px;
            border-top: 4px solid #0074b8;
            border-bottom: 1px solid #ddd;
            display: flex;
            align-items: center;
            padding: 0 35px;
        }

        .logo {
            font-size: 18px;
            font-weight: bold;
            width: 180px;
        }

        .menu {
            flex: 1;
            text-align: center;
        }

        .menu a {
            text-decoration: none;
            color: #777;
            margin: 0 14px;
            font-size: 14px;
        }

        .menu a.active {
            color: #1f4db8;
            font-weight: bold;
        }

        .right {
            width: 180px;
            text-align: right;
        }

        .right span {
            margin-right: 15px;
            font-size: 18px;
        }

        .logout {
            color: red;
            text-decoration: none;
            font-size: 13px;
        }

        .container {
            width: 75%;
            margin: 45px auto;
        }

        .search-row {
            display: flex;
            gap: 15px;
            margin-bottom: 35px;
        }

        .search-row input {
            flex: 1;
            padding: 10px 14px;
            border: 1px solid #999;
            border-radius: 2px;
        }

        .search-row select {
            width: 190px;
            padding: 10px;
            border: 1px solid #999;
            border-radius: 2px;
            background: white;
        }

        .classroom-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 35px 70px;
        }

        .class-card {
            background: #eaf9ff;
            border: 1px solid #bfd5df;
            border-radius: 12px;
            height: 120px;
            display: flex;
            align-items: center;
            padding: 18px 24px;
        }

        .book {
            font-size: 55px;
            color: #1f4db8;
            width: 95px;
            border-right: 1px solid #999;
            margin-right: 25px;
        }

        .info h2 {
            margin: 0;
            font-size: 26px;
        }

        .info p {
            margin: 7px 0 16px;
            font-size: 12px;
            color: #666;
        }

        .btn {
            background: #ff8c1a;
            color: white;
            border: none;
            border-radius: 9px;
            padding: 9px 16px;
            cursor: pointer;
            font-size: 13px;
        }

        .btn:hover {
            background: #e87900;
        }

        @media screen and (max-width: 900px) {
            .container {
                width: 90%;
            }

            .classroom-grid {
                grid-template-columns: 1fr;
                gap: 25px;
            }

            .search-row {
                flex-direction: column;
            }

            .search-row select {
                width: 100%;
            }

            .navbar {
                padding: 0 15px;
            }

            .menu a {
                margin: 0 5px;
                font-size: 12px;
            }

            .logo, .right {
                width: 120px;
            }
        }
    </style>
</head>

<body>

    <div class="navbar">
        <div class="logo">pathshala</div>

        <div class="menu">
            <a href="dashboard.jsp">Dashboard</a>
            <a href="classrooms.jsp" class="active">Classrooms</a>
            <a href="subjects.jsp">Subjects</a>
            <a href="payments.jsp">Payment</a>
        </div>

        <div class="right">
            <span>🔔</span>
            <span>👤</span>
            <a href="login.jsp" class="logout">Logout</a>
        </div>
    </div>

    <div class="container">

        <div class="search-row">
            <input type="text" placeholder="Search Classroom">
            <select>
                <option>All Classrooms</option>
                <option>Grade 4</option>
                <option>Grade 5</option>
                <option>Grade 6</option>
                <option>Grade 7</option>
                <option>Grade 8</option>
                <option>Grade 9</option>
                <option>Grade 10</option>
            </select>
        </div>

        <div class="classroom-grid">

            <%
                String[] grades = {"Grade 4", "Grade 5", "Grade 6", "Grade 7", "Grade 8", "Grade 9", "Grade 10"};

                for (int i = 0; i < grades.length; i++) {
            %>

            <div class="class-card">
                <div class="book">📖</div>

                <div class="info">
                    <h2><%= grades[i] %></h2>
                    <p>Full <%= grades[i] %> syllabus</p>
                    <button class="btn">Buy Package</button>
                </div>
            </div>

            <%
                }
            %>

        </div>

    </div>

</body>
</html>
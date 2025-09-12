<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 09/08/2025
  Time: 05:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Panel</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 400px;
            margin: 100px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
        }

        h1 {
            margin-bottom: 20px;
            font-size: 22px;
            color: #333;
        }

        a {
            display: block;
            margin: 12px 0;
            padding: 12px;
            text-decoration: none;
            background: #3498db;
            color: white;
            border-radius: 8px;
            font-weight: bold;
            transition: background 0.3s;
        }

        a:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🎓 Student Panel</h1>
    <a href="/seeLessons">See Lessons</a>
    <a href="/seeExamResults">See Exam Results</a>
    <a href="/seeMyAttendance">See My Attendance</a>
</div>
</body>
</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Hp
  Date: 9/9/2025
  Time: 3:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Teacher</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #2c3e50;
            padding: 12px 20px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }

        .navbar .logo {
            color: #ecf0f1;
            font-size: 22px;
            font-weight: bold;
            text-decoration: none;
        }

        .navbar ul {
            list-style: none;
            display: flex;
            margin: 0;
            padding: 0;
        }

        .navbar ul li {
            margin-left: 20px;
        }

        .navbar ul li a {
            text-decoration: none;
            color: #ecf0f1;
            font-size: 16px;
            padding: 8px 14px;
            border-radius: 6px;
            transition: 0.3s ease;
        }

        .navbar ul li a:hover {
            background: #3498db;
            color: #fff;
        }

        .btn {
            background: #3498db;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            text-decoration: none;
            transition: 0.3s;
        }

        .btn:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>
<div><c:out value="${message}"/></div>
<div class="navbar">
    <a href="" class="logo">Teacher Panel</a>
        <a href="/startLesson">Start Lesson</a>
        <a href="/markStudentsExam">mark students' exam</a>
        <a href="/seeGroupsExamResults">see exam results</a>
        <a href="/choose-chat">Write to Student</a>
</div>

</body>
</html>

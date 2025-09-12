<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 09/08/2025
  Time: 10:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student's Lessons</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #2c3e50;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #3498db;
            color: white;
            text-transform: uppercase;
            font-size: 14px;
        }

        tr:hover {
            background: #f1f9ff;
        }

        td {
            color: #333;
        }

        .completed {
            color: green;
            font-weight: bold;
        }

        .not-completed {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
<h1>📚 Student's Lessons</h1>
<table>
    <tr>
        <th>Lesson Number</th>
        <th>Teacher Name</th>
        <th>Group Name</th>
        <th>Module Number</th>
        <th>Room Number</th>
        <th>Starting Time</th>
        <th>Ending Time</th>
        <th>Odd/Even</th>
        <th>Date</th>
        <th>Completed</th>
    </tr>
    <c:forEach var="l" items="${lessons}">
        <tr>
            <td>${l.lessonNumber}</td>
            <td>${l.teacher.name} ${l.teacher.surname}</td>
            <td>${l.group.groupName}</td>
            <td>${l.moduleNumber}</td>
            <td>${l.group.room.number}</td>
            <td>${l.group.startTime}</td>
            <td>${l.group.endTime}</td>
            <td>${l.group.lessonDays}</td>
            <td>${l.date}</td>
            <td>
                <c:choose>
                    <c:when test="${l.isCompleted}">
                        <span class="completed">✔ Yes</span>
                    </c:when>
                    <c:otherwise>
                        <span class="not-completed">✘ No</span>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Make Attendance</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        form {
            background: #fff;
            padding: 20px;
            margin: 0 auto;
            width: 70%;
            border-radius: 10px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        th {
            background: #34495e;
            color: #fff;
        }

        tr:nth-child(even) {
            background: #f9f9f9;
        }

        tr:hover {
            background: #f1f1f1;
        }

        input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        button {
            display: block;
            margin: 20px auto 0;
            padding: 10px 20px;
            background: #3498db;
            color: #fff;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>

<h2>Attendance for Lesson ${lesson.lessonNumber}</h2>

<form action="/makeAttendance" method="post">
    <input type="hidden" name="lessonId" value="${lesson.id}"/>

    <table>
        <tr>
            <th>Student</th>
            <th>Present?</th>
        </tr>
        <c:forEach var="s" items="${students}">
            <tr>
                <td>${s.name} ${s.surname}</td>
                <td>
                    <input type="checkbox" name="present" value="${s.id}" checked>
                </td>
            </tr>
        </c:forEach>
    </table>

    <button type="submit">💾 Save Attendance</button>
</form>
</body>
</html>

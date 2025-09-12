<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Attendance</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            margin-bottom: 20px;
            color: #333;
        }

        table {
            border-collapse: collapse;
            width: 90%;
            max-width: 1000px;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
        }

        th {
            background: #4CAF50;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tr:nth-child(even) {
            background: #f2f2f2;
        }

        tr:hover {
            background: #e6ffe6;
        }

        td {
            color: #333;
        }

        .attended-true {
            color: green;
            font-weight: bold;
        }

        .attended-false {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
<h1>My Attendance</h1>
<table>
    <tr>
        <th>Full Name</th>
        <th>Lesson Number</th>
        <th>Teacher Name</th>
        <th>Group Name</th>
        <th>Lesson Start Time</th>
        <th>Lesson End Time</th>
        <th>Is Attended</th>
    </tr>

    <c:forEach items="${attendances}" var="a">
        <div><c:out value="${}"/></div>
        <tr>
            <td>${user.name} ${user.surname}</td>
            <td>${a.attendance.lesson.lessonNumber}</td>
            <td>${a.attendance.lesson.teacher.name} ${a.attendance.lesson.teacher.surname}</td>
            <td>${a.attendance.lesson.group.groupName}</td>
            <td>${a.attendance.lesson.group.startTime}</td>
            <td>${a.attendance.lesson.group.endTime}</td>
            <td class="${a.isAttended ? 'attended-true' : 'attended-false'}">
                    ${a.isAttended ? 'Present' : 'Absent'}
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Student List</title>
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
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
        }

        th {
            background-color: #2c3e50;
            color: #fff;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background: #f9f9f9;
        }

        tr:hover {
            background: #f1f1f1;
        }
    </style>
</head>
<body>
<h2>Student List</h2>

<table>
    <tr>
        <th>Name</th>
        <th>Surname</th>
        <th>Phone Number</th>
        <th>Text To Student</th>
    </tr>
    <c:forEach var="s" items="${students}">
        <tr>
            <td>${s.name}</td>
            <td>${s.surname}</td>
            <td>${s.phoneNumber}</td>
            <td>
                <a href="/chat?toUserId=${s.id}" class="btn">Text to Student</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>

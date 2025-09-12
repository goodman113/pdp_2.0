<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Groups</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 20px;
        }

        h2, h4 {
            text-align: center;
            color: #2c3e50;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 16px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #2c3e50;
            color: white;
        }

        tr:hover {
            background: #f9f9f9;
        }

        .btn {
            background: #3498db;
            color: white;
            padding: 6px 12px;
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

<h2>My Groups</h2>
<h4>choose a group to make actions</h4>
<table>
    <thead>
    <tr>
        <th>Group Name</th>
        <th>Room</th>
        <th>Module</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="g" items="${groups}">
        <tr>
            <td>${g.groupName}</td>
            <td>${g.room.number}</td>
            <td>${g.moduleNumber}</td>
            <td>
                <a href="/teacher-panel?groupId=${g.id}" class="btn">choose</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>

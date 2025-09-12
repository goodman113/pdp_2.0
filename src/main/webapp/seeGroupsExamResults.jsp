<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- Created by IntelliJ IDEA. User: USER Date: 09/08/2025 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Results</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f4f6f8;
      margin: 0;
      padding: 20px;
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #2c3e50;
    }

    .container {
      max-width: 1000px;
      margin: auto;
      background: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.2);
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 15px;
    }

    table th, table td {
      border: 1px solid #ddd;
      padding: 10px;
      text-align: center;
    }

    table th {
      background: #2c3e50;
      color: white;
      font-weight: bold;
    }

    table tr:nth-child(even) {
      background: #f9f9f9;
    }

    table tr:hover {
      background: #f1f1f1;
    }

    .no-results {
      text-align: center;
      color: #e74c3c;
      font-size: 18px;
      padding: 20px;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>Group Exam Results</h2>

  <c:choose>
    <c:when test="${empty examResults}">
      <div class="no-results">No results available for this group.</div>
    </c:when>
    <c:otherwise>
      <table>
        <tr>
          <th>Student Full Name</th>
          <th>Group Number</th>
          <th>Module Number</th>
          <th>Student Mark</th>
        </tr>
        <c:forEach var="e" items="${examResults}">
          <tr>
            <td>${e.student.name} ${e.student.surname}</td>
            <td>${e.exam.group.groupName}</td>
            <td>${e.exam.moduleNumber-1}</td>
            <td>${e.studentMark}</td>
          </tr>
        </c:forEach>
      </table>
    </c:otherwise>
  </c:choose>
</div>

</body>
</html>

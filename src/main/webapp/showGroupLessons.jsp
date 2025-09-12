<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %><html>
<head>
  <title>Group's Lessons</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f4f6f8;
      margin: 0;
      padding: 20px;
    }

    h1 {
      text-align: center;
      color: #2c3e50;
      margin-bottom: 20px;
    }

    form {
      text-align: center;
      margin-bottom: 20px;
    }


    button {
      background: #3498db;
      color: #fff;
      padding: 10px 18px;
      border: none;
      border-radius: 6px;
      font-size: 14px;
      cursor: pointer;
      transition: 0.3s;
    }

    button:hover {
      background: #2980b9;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 30px;
      background: #fff;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }

    th, td {
      padding: 12px 15px;
      text-align: center;
      border-bottom: 1px solid #eee;
    }

    th {
      background: #2c3e50;
      color: #fff;
      font-weight: 600;
    }

    tr:hover {
      background: #f9f9f9;
    }

    .completed {
      color: green;
      font-weight: bold;
    }

    .not-completed {
      color: red;
      font-weight: bold;
    }

    .present {
      color: #27ae60;
      font-weight: bold;
    }

    .absent {
      color: #e74c3c;
      font-weight: bold;
    }

    .attendance-table {
      margin-top: 10px;
      border: 1px solid #ddd;
    }

    .attendance-table th {
      background: #34495e;
      color: #fff;
    }

    .no-attendance {
      color: #7f8c8d;
      font-style: italic;
      margin: 10px 0;
    }
  </style>
</head>
<body>
<div style="color: #1d4ed8;align-items: center;font-size: 10px"><c:out value="${message}"/></div>

<h1>${group.groupName} - Lessons</h1>

<form action="/startLesson" method="post">
  <input type="hidden" value="${group.id}" name="groupId"/>
  <input name="lessonNumber" type="hidden" value="${fn:length(lessons) + 1}">
  <button type="submit">Start Lesson</button>
  <button type="button"><a href="teacher-panel.jsp">Back</a></button>
</form>


<c:if test="${not empty lessons}">
  <table>
    <tr>
      <th>Lesson Number</th>
      <th>Module Number</th>
      <th>Starting Time</th>
      <th>Ending Time</th>
      <th>Odd/Even</th>
      <th>Date</th>
      <th>Completed</th>
    </tr>
    <c:forEach var="l" items="${lessons}">
      <tr>
        <td>${l.lessonNumber}</td>
        <td>${l.moduleNumber}</td>
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

      <!-- Attendance for this lesson -->
      <tr>
        <td colspan="8">
          <c:set var="attendances" value="${lessonAttendances[l.id]}"/>
          <c:if test="${not empty attendances}">
            <table class="attendance-table" width="100%">
              <tr>
                <th>Student</th>
                <th>Status</th>
              </tr>
              <c:forEach var="sa" items="${attendances}">
                <tr>
                  <td>${sa.student.name} ${sa.student.surname}</td>
                  <td>
                    <c:choose>
                      <c:when test="${sa.isAttended}">
                        <span class="present">✔ Present</span>
                      </c:when>
                      <c:otherwise>
                        <span class="absent">✘ Absent</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </table>
          </c:if>
          <c:if test="${empty attendances}">
            <p class="no-attendance">No attendance recorded yet.</p>
          </c:if>
        </td>
      </tr>
    </c:forEach>
  </table>
</c:if>
</body>
</html>

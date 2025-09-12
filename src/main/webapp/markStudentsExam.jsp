<%-- Created by IntelliJ IDEA. User: USER Date: 09/12/2025 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Mark Students</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: #f4f6f8;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
        }

        .container {
            max-width: 800px;
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

        table, th, td {
            border: 1px solid #ddd;
        }

        th {
            background: #2c3e50;
            color: white;
            padding: 10px;
            text-align: left;
        }

        td {
            padding: 12px;
        }

        /* prettier input styles */
        input[type="number"] {
            width: 80px;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
            outline: none;
        }

        input[type="number"]:focus {
            border-color: #3498db;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.4);
        }

        input[type="number"]::-webkit-outer-spin-button,
        input[type="number"]::-webkit-inner-spin-button {
            margin: 0;
        }

        /* button styling */
        button {
            display: block;
            margin: 20px auto 0;
            padding: 12px 24px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            transition: 0.3s;
        }

        button:hover {
            background: #2980b9;
        }

        .no-exam {
            text-align: center;
            padding: 20px;
            color: #e74c3c;
            font-size: 18px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">

    <c:choose>
        <c:when test="${empty exam}">
            <div class="no-exam">There is no exam for this group.</div>
        </c:when>
        <c:otherwise>
            <h2>Mark Students for Exam (Module ${exam.moduleNumber-1})</h2>

            <form action="/markStudentsExam" method="post">
                <input type="hidden" name="examId" value="${exam.id}">
                <table>
                    <tr>
                        <th>Student</th>
                        <th>Mark</th>
                    </tr>
                    <c:forEach var="er" items="${examResults}">
                        <tr>
                            <td>${er.student.name} ${er.student.surname}</td>
                            <td>
                                <input type="number" name="student_${er.student.id}"
                                       value="${er.studentMark}" min="0" max="100">
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <c:if test="${exam.isCompleted == false}">
                <button type="submit">Save Marks</button>
                </c:if>
            </form>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
